images_dir=$1

if [ ! $images_dir ]; then
    echo -e "ERROR!\n        Usage: sh load_images.sh <images_dir>\n"
    exit 1
fi

pushd $images_dir
for zipped_file in `ls | grep .tar.gz`;
do
    tar_file=${zipped_file%.*}
    echo "unizp "$zipped_file" -> "$tar_file
    tar -xzvf $zipped_file
    docker load --input $tar_file
    rm -rf $tar_file
done
popd
