# Use the Amazon Linux base image
FROM amazonlinux:2

# Install dependencies, Java 11, and Maven
RUN yum update -y && \
    yum install -y git tar wget unzip python3 python3-pip curl openssl && \
    RUN curl -s "https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.tar.gz" -o jdk.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar -xzf jdk.tar.gz -C /usr/lib/jvm && \
    rm jdk.tar.gz && \
    ln -s /usr/lib/jvm/jdk-23*/bin/java /usr/bin/java && \
    ln -s /usr/lib/jvm/jdk-23*/bin/javac /usr/bin/javac && \
    echo 'export JAVA_HOME=/usr/lib/jvm/jdk-23*' >> /etc/profile && \
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
    yum clean all

# Install Maven 3.9.4
RUN cd /opt && \
    wget https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz && \
    tar xvf apache-maven-3.9.4-bin.tar.gz && \
    rm apache-maven-3.9.4-bin.tar.gz

# Set environment variables
ENV M2_HOME=/opt/apache-maven-3.9.4
ENV PATH=$M2_HOME/bin:$PATH

# Install Terraform
RUN cd /opt && \
    wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip && \
    unzip terraform_1.0.7_linux_amd64.zip && \
    rm terraform_1.0.7_linux_amd64.zip && \
    mv terraform /usr/local/bin/

# Install kubectl
RUN cd /usr/local/bin && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl

# Create app directory
WORKDIR /app

# Copy project files into the container
COPY . /app

# Build the Spring Boot application
RUN mvn clean package -DskipTests

# Set the JAR file name (update if your jar name is different)
ENV JAR_FILE=target/booking-ms-1.1.jar

# Run the application
CMD ["java", "-jar", "target/booking-ms-1.1.jar"]
