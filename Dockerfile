FROM amazonlinux:2

WORKDIR /docker/

RUN amazon-linux-extras install python3
RUN yum install -y wget unzip zip
RUN pip3 install --upgrade pip awscli

RUN wget --quiet https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
RUN unzip terraform_0.11.8_linux_amd64.zip
RUN mv terraform /usr/bin

ADD . .

RUN pip3 install -r app/requirements.txt