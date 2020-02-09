const token = process.env.token;
if (token) {
  console.log(`token: ${token}\n`);
} else {
  console.error('no token.\n');
}
