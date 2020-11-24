FROM ubuntu:latest

# this sed command adds alpine edge repository
RUN apt-get update \
  && apt-get install -y ansible git \
  && git clone https://github.com/bearddan2000/ansible-lib-playbooks.git \
  && chmod -R +x ansible-lib-playbooks \
  && ansible-playbook ansible-lib-playbooks/webservers/apache-default.yml \
  && rm -f /var/www/html/index.html

COPY bin/ /var/www/html

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R +x /var/www/html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
