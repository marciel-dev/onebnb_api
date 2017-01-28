#Imagem cujo sera utilizada para gerar o container
FROM ruby:2.3-slim

#Instalar as dependencias
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev

# Setando o PATH
ENV INSTALL_PATH /onebnb_api

#Criando o diretorio
RUN mkdir -p $INSTALL_PATH

# Setando o path como diretorio principal
WORKDIR $INSTALL_PATH

#Copiando o Gemfile para dentro do container
COPY Gemfile Gemfile.lock ./

#Instalando as Gems
RUN bundle install

# Copiando o codigo para dentro do container
COPY . .

#Rodando o servidor

CMD puma -C config/puma.rb
