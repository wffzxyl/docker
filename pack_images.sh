images_dir=images_`date +"%Y-%m-%d"`
mkdir $images_dir

save_image () {
    pushd $images_dir
    image=$1
    saved_file=`echo ${image} | awk -F / '{print $NF}' | sed 's/:/-/g'`.tar
    zipped_file=$saved_file.gz
    if [ ! -f "$zipped_file" ]; then
      echo "saving $image ..."
      docker save $image > ${saved_file}
      tar -czvf ${zipped_file} ${saved_file}
      rm ${saved_file}
    fi
    popd
}

for image in $(cat *.yml | grep image | grep -v '#' | awk '{print $2}');
do
save_image $image
done
