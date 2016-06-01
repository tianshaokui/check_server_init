#!/usr/bin/env python
#coding=utf-8
#2016.05.30 
#author=tianshaokui
import ansible.runner
import ansible.inventory
import sys
import os
class check(object):
	def __init__(self, hosts, shel_cript='ping', std_out=None):
                self.hosts = hosts
		self.std_out = std_out
		self.shel_cript = shel_cript
		self.check_name = shel_cript.split('/')[-1][:-3] if shel_cript!='ping' else 'ping'
	def judge_qualified(self, out_info):
		std_out = set([x[:-1] for x in open(self.std_out)]) if os.path.isfile(self.std_out) else set([])
		unqua_leave = tuple( set(out_info) - std_out)
		unqua_lack = tuple( std_out - set(out_info))
		return (unqua_leave, unqua_lack)
	def get_qualified_list(self):
		return self.qualfd
	def get_unqualified_info(self):
		return self.unqualfd
	def get_check_name(self):
		return self.check_name

class check_ping(check):
	def run_check(self):
		runner = ansible.runner.Runner(
        	       host_list = self.hosts,
                       module_name = self.shel_cript,
                       forks = 20,
		)
		info = runner.run()
		self.qualfd, self.unqualfd = info['contacted'].keys(), [(x,False) for x in info['dark'].keys()]

class check_module_tmp(check):
        def run_check(self):
                runner = ansible.runner.Runner(
                	host_list = self.hosts,
        		module_name = 'script',
        		module_args = self.shel_cript,
        		forks = 20,
		)
                info=runner.run()['contacted']
		get_inf = [(x,self.judge_qualified( info[x]['stdout'].split('\r\n')[:-1])) for x in info.keys()]
		self.qualfd = [ x[0] for x in get_inf if x[1]==((),())]
		self.unqualfd = [ x for x in get_inf if x[1]!=((),())]
		
if __name__ == '__main__':
	ping = check_ping(sys.argv[1])
        ping.run_check()
        print ping.get_check_name(), ping.get_qualified_list(), ping.get_unqualified_info()
        hosts=ping.get_qualified_list()
	# 遍历检测所有模块
	script =  [i[:-3] for i in os.listdir('./shell_scrpt/') if os.path.splitext(i)[1]=='.sh']
	for i in script:
		temp=check_module_tmp(hosts, './shell_scrpt/'+i+'.sh', './module_std_out/'+i)
		temp.run_check()
		print temp.get_check_name(), temp.get_qualified_list(), temp.get_unqualified_info()




