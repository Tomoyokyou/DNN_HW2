if [ -f feature.tar.gz ] || [ -d deeplearningHW2_data ]; then
echo "already download features, skip..."
else
echo "no example feature, start downloading..."
wget https://www.dropbox.com/s/7lyq8dp0oj2o7wf/feature.tar.gz?dl=1 -O feature.tar.gz
tar zxvf feature.tar.gz
fi

