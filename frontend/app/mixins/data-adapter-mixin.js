import Ember from 'ember';
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';

const {
  get,
  Mixin,
  setProperties,
} = Ember;

export default Mixin.create(DataAdapterMixin, {
  handleResponse(_, headers) {
    let store = get(this, 'session.session.store');
    let authenticated = get(this, 'session.session.authenticated');

    if (headers['access-token'] && headers.expiry > authenticated.expiry) {
      setProperties(authenticated, {
        uid: headers['uid'],
        client: headers['client'],
        expiry: headers['expiry'],
        tokenType: headers['token-type'],
        accessToken: headers['access-token'],
      });

      store.persist({ authenticated });
    }

    return this._super(...arguments);
  },
});
