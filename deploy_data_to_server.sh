WORKDIR="HOG-SVM-python"

# Deploy train bash
# scp opencv_createsamples.sh lky@192.168.3.130:$WORKDIR/
# scp opencv_traincascade.sh lky@192.168.3.130:$WORKDIR/
# scp run_train_test_on_server.sh lky@192.168.3.130:$WORKDIR/

# Deploy python
# scp visualizer_py/requirements.txt lky@192.168.3.130:$WORKDIR/visualizer_py/
# scp visualizer_py/saved_detected_img.py lky@192.168.3.130:$WORKDIR/visualizer_py/
# scp visualizer_py/utility.py lky@192.168.3.130:$WORKDIR/visualizer_py/
# scp -r server_py/* lky@192.168.3.130:$WORKDIR/server_py/

# Deploy Node
# scp -r node_server/* lky@192.168.3.130:$WORKDIR/node_server/

# Deploy dataset
# scp -rpC img lky@192.168.3.130:$WORKDIR/
tar --exclude=".*" --disable-copyfile -czf - data/images/ | ssh lky@192.168.3.130 "cd ${WORKDIR}/ && tar xvzf -"

# # run
# ssh lky@192.168.3.130 << EOF
#     echo "lkypwd" | sudo -S sudo docker rmi wastebin_detect_by_cascade -f
#     echo "lkypwd" | sudo -S sudo docker load -i /tmp/wastebin_detect_by_cascade.tar
#     echo "lkypwd" | sudo -S sudo docker stop lky_wastebin_detect_by_cascade
#     echo "lkypwd" | sudo -S sudo docker rm lky_wastebin_detect_by_cascade
#     echo "lkypwd" | sudo -S sudo docker run --name lky_wastebin_detect_by_cascade wastebin_detect_by_cascade
# EOF

# For Server
# mkdir -p WasteBinDetectByCascade/visualizer_py/