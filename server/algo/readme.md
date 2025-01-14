## Welcome
This is a simple micro service calling a simple index

```py
exports.handler = async (event) => {
  const name = event.queryStringParameters.name;
  const response = {
    statusCode: 200,
    body: JSON.stringify(`Hello, ${name}!`),
  };
  return response;
};
```
