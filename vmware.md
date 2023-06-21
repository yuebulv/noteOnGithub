## windows 10

### 激活

https://www.bilibili.com/video/BV1jb4y1p7mr/?spm_id_from=333.337.search-card.all.click&vd_source=71766beb4ab755e8dfb4543e1008fa76

slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX

slmgr /skms kms.03k.org

slmgr /ato

## VMware安装

## Kali

教程：[6-解决Kali软件包安装存在的依赖问题_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1SM411B7ry/?p=6)

### Kali Linux安装

1. 下载官网www.kail.org
2. 虚拟机安装：
   - VMware->文件->打开.vmx文件
   - iso文件安装:  VMware->新建虚拟机->稍后安装操作系统->Linux--版本deban 8.x->安装位置->默认；双击CD/DVD->使用iso映象文件中指定iso文件
   - 开启此虚拟机->Graphical install->选择语言->默认->是否将改动写入磁盘：是->默认
   - reboot重启虚拟机->

### 命令

1. apt update 检查更新，看是否有需要更新的软件（任何软件更新时都要运行此命令 ）
2. apt -y full-upgrade 更新软件、系统（不建议此方法）
3. gnome-tweaks 桌面布局设置
4. apt-get install gnome-shell-extension-desktop-icons右键扩展
5. apt upgrade 更新软件（有软件依赖问题的软件不会更新）
6. apt dis-upgrade 更新软件（有软件依赖问题的软件也会尝试去更新）
7. 安装内核头linux-header和编译工具gcc,make
   - apt-get install gcc make linux-headers-$(uname -r)
   - uname -r 表示当表kali内核
8. 扩展：apt和apt-get区别
   apt可以看作apt-get和apt-cache命令的子集，可以为包管理提供必要的命令选顶。
   apt提供了大多数与apt-get及apt-cache有的功能，但更方便使用
   apt-get虽然没被弃用，但作为普通用户，还是应该首先使用apt。
   注：apt install和apt-get install功能一样，都是安装软件包，没有区别。
9. 关机->拍摄快照
10. 快照管理器->转到，可以恢复系统

## VMware tools安装

1. kali: 装好kali后，从光盘的VMware tools.tar.gz文件复制出来，解压->进入到有vmware-install.pl文件的文件夹下->运行sudo ./vmware-install.pl -d
2. apt install open-vm-tools-desktop fuse实现物理机和kali之间自由拖拽文件和复制内容，比vmware tools好用

### win7 X86中安装VMware tools

1. 需要安装补丁KB4474419

根据这个博客，我知道了没有VM tools可以通过U盘拷贝下载好的补丁文件。所以我就先把下载好的补丁文件拷贝到U盘里，然后拔出U盘，再打开虚拟机win7界面插入U盘，选择window7系统，这样就能从U盘里面拷贝文件到虚拟机中的win7系统啦。

然后安装补丁。补丁安装完成后重启win7。

2. 安装VM tools

右键windows 7，选择 安装VMware Tools。

然后打开任务栏第三个图标：资源管理器【那个文件夹的形状】

双击DVD驱动器安装VM tools。按照提示按照即可！

