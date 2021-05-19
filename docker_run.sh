# run training and testing on container on the server.
docker stop lky_hog_svm_python && docker rm lky_hog_svm_python
WORKDIR="/Users/lky/code_repos/HOG-SVM-python"
docker run -p 5001:5001 -it --rm \
    --name lky_hog_svm_python \
    --mount type=bind,source=$WORKDIR/object-detector,target=/app/object-detector,readonly \
    --mount type=bind,source=$WORKDIR/data/images,target=/app/images,readonly \
    --mount type=bind,source=$WORKDIR/data/features,target=/app/features \
    hog_svm_python \
    /bin/bash -c "cd object-detector; \
         python3 extract_features.py -p ../data/images/pos -n ../data/images/neg; \
         python3 train_classifier.py -p ../data/features/pos -n ../data/features/neg -c ONE_CLASS_SVM; \
         python3 test_classifier.py -i ../data/images/test"