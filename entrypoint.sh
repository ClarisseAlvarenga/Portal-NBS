#!/bin/sh

file="populado.txt"
if [ -f "$file" ]
then
	echo "$file found."
else
    rake db:migrate
    rake iqvoc:import:url URL=data/NBS2-skos.nt NAMESPACE='http://vocab.mdic.gov.br/NBS/v2.0/'
    echo "Banco Populado" > populado.txt
    export PGPASSWORD='iqvoc' && psql -h db -p 5432 -U iqvoc iqvoc_production -c 'CREATE EXTENSION unaccent;'
fi

rake assets:precompile
bundle exec rake db:migrate
bundle exec rake db:seed
bin/delayed_job start
exec bundle exec passenger start --port 3000 --environment $RAILS_ENV