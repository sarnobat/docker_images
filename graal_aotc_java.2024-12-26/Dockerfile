# not good enough, no gradle

FROM container-registry.oracle.com/graalvm/graalvm-community:17.0.8-ol8
CMD ["echo", "Hello StackOverflow"]
COPY proj /proj
# This will make apt use default answers for interactive questions
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/sh

WORKDIR /proj/

RUN ./gradlew build
RUN ./gradlew nativeCompile -b build.gradle

# RUN ./gradlew :wrapper

