FROM ruby:2.3.1

RUN gem install fluentd --no-ri --no-rdoc
RUN useradd -m fluentd
RUN mkdir /etc/fluent
RUN chown fluentd:fluentd /etc/fluent
RUN mkdir /var/log/fluent
RUN chown fluentd:fluentd /var/log/fluent/
USER fluentd
WORKDIR /etc/fluent
RUN fluentd --setup ./
COPY ./fluent.conf /etc/fluent/
CMD ["fluentd"]
