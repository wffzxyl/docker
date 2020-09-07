#!/bin/sh

if [ $# -ne 2 ]
then
    tag=2.0-dockerize
    deploy=0
    echo "Usage: sh $0 tag 1/0"
    echo ""
else
    tag=$1
    deploy=$2
fi
echo "Now you are packaging branch/tag "$tag
des=yskg-$tag.tar.gz

if [ -d yskg-deploy ];then
     rm -rf yskg-deploy
fi
git clone -b $tag  ssh://git@git.datagrand.com:58422/ykg/yskg-deploy.git

if [ ! -f share_jars.tar.gz ];then
    #wget ftp://yskg:27232d30cdc1@ftp.datagrand.com:50100/share_jars.tar.gz
    curl ftp://ftp.datagrand.com:50100/share_jars.tar.gz -u yskg:27232d30cdc1 -o share_jars.tar.gz
fi

# package
tar -xzvf share_jars.tar.gz -C yskg-deploy/data/
find yskg-deploy/ -name ".gitignore" -exec rm {} \;
rm -rf yskg-deploy/.git
rm yskg-deploy/develop.md
rm yskg-deploy/CHANGELOG.md
rm yskg-deploy/pack_data.sh
tar -czvf $des yskg-deploy

# upload ftp
curl -u yskg:27232d30cdc1 -T $des ftp://ftp.datagrand.com:50100/publish/

if [ ""$deploy -eq "1" ];then
    curl -u yskg:27232d30cdc1 -T $des ftp://ftp.datagrand.com:50100/publish/yskg-deploy.tar.gz
fi
