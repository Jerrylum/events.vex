curl -o events.vex.yaml https://events.vex.com/api/v2/swagger.yml
npx openapi-typescript ./events.vex.yaml --output ../src/generated/events.vex.ts --export-type --default-non-nullable --proprties-required-by-default
