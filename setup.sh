
arch=$(uname -m)
export LTTNG_SESSIOND_PATH=~/bin
export LTTNG_SESSION_CONFIG_XSD_PATH=~/share/xml/lttng/
export LTTNG_CONSUMERD32_BIN=~/lib/lttng/libexec/lttng-consumerd
export LTTNG_CONSUMERD64_BIN=~/lib/lttng/libexec/lttng-consumerd
export PYTHONPATH=~/lib/python3.4/site-packages/
export PATH=~/bin:$PATH
export LD_LIBRARY_PATH=~/lib:$LD_LIBRARY_PATH

case $arch in
	x86_64)
		URCU_ARCHIVE="https://ci.lttng.org/view/Liburcu/job/liburcu_master_build/arch=x86-64,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		UST_ARCHIVE="https://ci.lttng.org/view/LTTng-ust/job/lttng-ust_master_build/arch=x86-64,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		TOOLS_ARCHIVE="https://ci.lttng.org/view/LTTng-tools/job/lttng-tools_master_build/arch=x86-64,babeltrace_version=master,build=std,conf=python-bindings,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		BABELTRACE_ARCHIVE="https://ci.lttng.org/view/Babeltrace/job/babeltrace_master_build/arch=x86-64,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		;;
	i686)
		URCU_ARCHIVE="https://ci.lttng.org/view/Liburcu/job/liburcu_master_build/arch=x86-32,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		UST_ARCHIVE="https://ci.lttng.org/view/LTTng-ust/job/lttng-ust_master_build/arch=x86-32,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		TOOLS_ARCHIVE="https://ci.lttng.org/view/LTTng-tools/job/lttng-tools_master_build/arch=x86-32,babeltrace_version=master,build=std,conf=python-bindings,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		BABELTRACE_ARCHIVE="https://ci.lttng.org/view/Babeltrace/job/babeltrace_master_build/arch=x86-32,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"

		;;
	ppc)
		URCU_ARCHIVE="https://ci.lttng.org/view/Liburcu/job/liburcu_master_portbuild/arch=powerpc,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		UST_ARCHIVE="https://ci.lttng.org/view/LTTng-ust/job/lttng-ust_master_portbuild/arch=powerpc,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		TOOLS_ARCHIVE="https://ci.lttng.org/view/LTTng-tools/job/lttng-tools_master_portbuild/arch=powerpc,babeltrace_version=master,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		BABELTRACE_ARCHIVE=https://ci.lttng.org/view/Babeltrace/job/babeltrace_master_portbuild/arch=powerpc,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip
		;;
	ppc64le)
		URCU_ARCHIVE="https://ci.lttng.org/view/Liburcu/job/liburcu_master_portbuild/arch=ppc64el,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		UST_ARCHIVE="https://ci.lttng.org/view/LTTng-ust/job/lttng-ust_master_portbuild/arch=ppc64el,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		TOOLS_ARCHIVE="https://ci.lttng.org/view/LTTng-tools/job/lttng-tools_master_portbuild/arch=ppc64el,babeltrace_version=master,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		BABELTRACE_ARCHIVE=https://ci.lttng.org/view/Babeltrace/job/babeltrace_master_portbuild/arch=ppc64el,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip
		;;
	armv7l)
		URCU_ARCHIVE="https://ci.lttng.org/view/Liburcu/job/liburcu_master_portbuild/arch=armhf,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		UST_ARCHIVE="https://ci.lttng.org/view/LTTng-ust/job/lttng-ust_master_portbuild/arch=armhf,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		TOOLS_ARCHIVE="https://ci.lttng.org/view/LTTng-tools/job/lttng-tools_master_portbuild/arch=armhf,babeltrace_version=master,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		BABELTRACE_ARCHIVE=https://ci.lttng.org/view/Babeltrace/job/babeltrace_master_portbuild/arch=armhf,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip
		;;
	aarch64)
		URCU_ARCHIVE="https://ci.lttng.org/view/Liburcu/job/liburcu_master_portbuild/arch=arm64,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		UST_ARCHIVE="https://ci.lttng.org/view/LTTng-ust/job/lttng-ust_master_portbuild/arch=arm64,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		TOOLS_ARCHIVE="https://ci.lttng.org/view/LTTng-tools/job/lttng-tools_master_portbuild/arch=arm64,babeltrace_version=master,build=std,conf=std,liburcu_version=master/lastSuccessfulBuild/artifact/*zip*/archive.zip"
		BABELTRACE_ARCHIVE=https://ci.lttng.org/view/Babeltrace/job/babeltrace_master_portbuild/arch=arm64,build=std,conf=std/lastSuccessfulBuild/artifact/*zip*/archive.zip
		;;
esac

wget --no-check-certificate $URCU_ARCHIVE -O urcu.zip
wget --no-check-certificate $UST_ARCHIVE -O ust.zip
wget --no-check-certificate $BABELTRACE_ARCHIVE -O babeltrace.zip
wget --no-check-certificate $TOOLS_ARCHIVE -O  tools.zip

mkdir deps

for f in *.zip ; do bsdtar --strip-components 2 -xvzf $f -C ~; done

chmod -R +x ~/bin
chmod -R +x ~/lib/lttng/libexec/lttng-consumerd

GIT_SSL_NO_VERIFY=true git clone http://github.com/psrcode/lttng-modules

make

