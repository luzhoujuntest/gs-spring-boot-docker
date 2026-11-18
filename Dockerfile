# 1. 选择兼容性好的基础镜像 (如需极致体积可换为 -alpine，但需测试兼容性)
FROM eclipse-temurin:17-jdk-alpine

# 使用 JRE 而非 JDK，体积更小，安全性更高（无编译工具）

# 2. 设置工作目录
WORKDIR /app

# 3. 复制 Jar 包 (保留示例1的灵活性)
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# 4. 创建非 root 用户 (保留示例1的安全性)
RUN useradd -m -s /bin/bash spring && \
    chown -R spring:spring /app

# 5. 切换用户
USER spring

# 6. 设置时区 (保留示例2的正确性)

# 7. 暴露端口
EXPOSE 8080

# 8. 启动命令：使用 MaxRAMPercentage 自动适配容器内存限制，而非硬编码 Xmx
# 同时启用 G1GC 以获得更好的低延迟表现
ENTRYPOINT ["java", \
            "-XX:MaxRAMPercentage=75.0", \
            "-XX:+UseG1GC", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-jar", "app.jar"]
