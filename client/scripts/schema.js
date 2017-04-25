const fs = require('fs');
const request = require('request');
const { buildClientSchema, printSchema } = require('graphql/utilities');

request('http://localhost:3000/graphql', function(error, response, body) {
  if (!error && response.statusCode == 200) {
    const schemaJson = JSON.parse(body);
    const schema = buildClientSchema(schemaJson.data);

    fs.writeFileSync(
      `../schema/schema.graphql`,
      printSchema(schema)
    );
  }
});
