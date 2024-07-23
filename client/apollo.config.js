module.exports = {
  client: {
    service: {
      name: 'ecommerce_shop',
      url: 'http://localhost:3000/graphql',
    },
    includes: [
      'src/**/*.vue',
      'src/**/*.ts',
    ],
  },
}