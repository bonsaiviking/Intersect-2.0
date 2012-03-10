def Gather_OS():
   print("[+] Collecting operating system and user information....")
   os.mkdir(Temp_Dir+"/osinfo/")
   os.chdir(Temp_Dir+"/osinfo/")
   
   proc = Popen('ps aux',
                shell=True, 
                stdout=PIPE,
                )
   output = proc.communicate()[0]
   file = open("ps_aux.txt","a")
   for items in output:
       file.write(items),
   file.close()

   os.system("ls -alh /usr/bin > bin.txt")
   os.system("ls -alh /usr/sbin > sbin.txt")
   os.system("ls -al /etc/cron* > cronjobs.txt")
   os.system("ls -alhtr /media > media.txt")

   if distro == "ubuntu" or distro2 == "Ubuntu":
      os.system("dpkg -l > dpkg_list.txt")
   elif distro == "arch" or distro2 == "Arch":
      os.system("pacman -Q > pacman_list.txt")
   elif distro == "slackware" or distro2 == "Slackware":
      os.system("ls /var/log/packages > packages_list.txt")
   elif distro == "gentoo" or distro2 == "Gentoo":
      os.system("cat /var/lib/portage/world > packages.txt")
   elif distro == "centos" or distro2 == "CentOS":
      os.system("yum list installed > yum_list.txt")
   elif distro == "red hat" or distro2 == "Red Hat":
      os.system("rpm -qa > rpm_list.txt")
   else:
      pass
   
   if distro == "arch":
      os.system("egrep '^DAEMONS' /etc/rc.conf > services_list.txt")
   elif distro == "slackware":
      os.system("ls -F /etc/rc.d | grep \'*$\' > services_list.txt")
   elif whereis('chkconfig') is not None:
      os.system("chkconfig -A > services_list.txt")

   os.system("mount -l > mount.txt")
   os.system("cat /etc/sysctl.conf > sysctl.txt")
   os.system("find /var/log -type f -exec ls -la {} \; > loglist.txt")
   os.system("uname -a > distro_kernel.txt")
   os.system("df -hT > filesystem.txt")
   os.system("free -lt > memory.txt")
   os.system("locate sql | grep [.]sql$ > SQL_locations.txt")
   os.system("find /home -type f -iname '.*history' > HistoryList.txt")
   os.system("cat /proc/cpuinfo > cpuinfo.txt")
   os.system("cat /proc/meminfo > meminfo.txt")

   if os.path.exists(Home_Dir+"/.bash_history") is True:
        shutil.copy2(Home_Dir+"/.bash_history", "bash_history.txt")
   if os.path.exists(Home_Dir+"/.viminfo") is True:
       shutil.copy2(Home_Dir+"/.viminfo", "viminfo")
   if os.path.exists(Home_Dir+"/.mysql_history") is True:
       shutil.copy2(Home_Dir+"/.mysql_history", "mysql_history")
   
   sysfiles = ["distro_kernel.txt","filesystem.txt","memory.txt","cpuinfo.txt","meminfo.txt"]
   content = ''
   for f in sysfiles:
       content = content + '\n' + open(f).read()
   open('SysInfo.txt','wb').write(content)
   os.system("rm distro_kernel.txt filesystem.txt memory.txt cpuinfo.txt meminfo.txt")
   
   os.mkdir("users/")
   os.chdir("users/")
   
   os.system("ls -alhR ~/ > CurrentUser.txt")
   os.system("ls -alhR /home > AllUsers.txt")
   if os.path.exists(Home_Dir+"/.mozilla/") is True:
       os.system("find "+Home_Dir+"/.mozilla -name bookmarks*.json > UsersBookmarks.txt")

   
