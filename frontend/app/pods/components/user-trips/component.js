import Ember from 'ember';
import DestroyConfirmable from '../../../mixins/destroy-confirmable';

const {
  get,
  set,
  observer,
  Component,
  getProperties,
  run: {
    debounce,
  },
  inject: {
    service,
  },
  computed: {
    not,
    alias,
  },
} = Ember;

export default Component.extend(DestroyConfirmable, {
  store: service(),

  userId: alias('user.id'),
  noTrips: not('trips.length'),

  termChanged: observer('tripsTerm', function() {
    debounce(this, this.queryTrips, 300);
  }),

  datesChanged: observer('maxEndDate', 'minStartDate', function() {
    this.queryTrips();
  }),

  queryTrips() {
    const keys = ['userId', 'tripsTerm', 'maxEndDate', 'minStartDate'];
    const filter = getProperties(this, ...keys);

    get(this, 'store')
      .query('trip', this.decamelizeKeys(filter, keys))
      .then(trips => set(this, 'trips', trips));
  },

  decamelizeKeys(obj, keys) {
    let newObj = {};

    keys.forEach(key => newObj[key.decamelize()] = obj[key]);

    return newObj;
  },
});
