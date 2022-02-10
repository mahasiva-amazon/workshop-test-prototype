docker run -it -e "CLUSTER_NAME=eks-playground" -e "AWS_DEFAULT_REGION=us-west-2" -v $PWD/../testcontent:/content -v $HOME/.aws/credentials:/root/.aws/credentials:ro remark-test

CONTENT_PATH=../testcontent npm test