FROM jekyll/jekyll:4.2.2

### Install ncurses for pretty output
RUN apk -v --update add ncurses

### Copy over the entrypoint shell script
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
