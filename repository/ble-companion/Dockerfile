ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

COPY run.sh /
COPY bluetooth_le_companion.config /

RUN apk add ruby-dev libcap-dev gcc make libffi libc-dev git
RUN unset BUNDLE_PATH
RUN unset BUNDLE_BIN

RUN git clone https://github.com/kirichkov/home_assistant-ble.git
RUN cd home_assistant-ble/ && gem build home_assistant-ble.gemspec
RUN cd home_assistant-ble/ && find . -name "home_assistant-ble-*.gem" -exec gem install '{}' --no-document \;
RUN gem install json --no-document
RUN chmod +x /run.sh

CMD [ "/run.sh" ]