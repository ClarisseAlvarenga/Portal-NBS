#!/bin/sh

file="populado.txt"
if [ -f "$file" ]
then
	echo "$file found."
else
    rake db:migrate
    rake iqvoc:import:url URL=data/NBS2-skos.nt NAMESPACE='http://vocab.mdic.gov.br/NBS/v2.0/'
    echo "Banco Populado" > populado.txt
fi

rake assets:precompile && bundle exec rake db:migrate && bundle exec rake db:seed && bin/delayed_job start && exec bundle exec passenger start --port 3000 --environment $RAILS_ENV