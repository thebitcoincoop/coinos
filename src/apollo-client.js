import Vue from 'vue'
import { ApolloClient } from 'apollo-client'
import { HttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'
import VueApollo from 'vue-apollo'

const httpLink = new HttpLink({
  uri: 'http://192.168.1.64:3000/graphql',
})

const dataIdFromObject = o => {
  if (o.id) { return o.id }
}

const apolloClient = new ApolloClient({
  link: httpLink,
  cache: new InMemoryCache({
    dataIdFromObject,
    cacheResolvers: {},
  }),
  connectToDevTools: true,
})

Vue.use(VueApollo)

export default apolloClient
