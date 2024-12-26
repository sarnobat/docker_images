# not good enough, no gradle

FROM container-registry.oracle.com/graalvm/graalvm-community:latest
CMD ["echo", "Hello StackOverflow"]
COPY proj /proj
# This will make apt use default answers for interactive questions
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/sh

