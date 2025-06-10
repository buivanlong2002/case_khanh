FROM tomcat:9-jdk17-temurin

# Xóa các ứng dụng mặc định (nếu cần gọn)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR vào thư mục deploy của Tomcat
COPY build/libs/PersonalWebsite-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Mở port 8080
EXPOSE 8080

# Dùng entrypoint mặc định của Tomcat
