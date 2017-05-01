import Ember from 'ember';
import pdfMake from 'ember-pdfmake';
import DestroyConfirmable from '../../../mixins/destroy-confirmable';

import { formatDate } from '../../../helpers/format-date';

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

  styles: {
    dates: {
      bold: true,
      fontSize: 12,
    },
    comment: {
      fontSize: 14,
      margin: [0, 5, 0, 10],
    },
    destination: {
      bold: true,
      fontSize: 16,
    },
  },

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

  actions: {
    exportPdf() {
      let content = [];
      const format = 'YYYY-MM-DD';
      const trimmer = /\s+/g;
      const sanitizer = /(<([^>]+)>)/ig;

      const { trips, styles } = getProperties(this, 'trips', 'styles');

      trips.forEach(trip => {
        const {
          comment,
          endDate,
          startDate,
          destination,
        } = getProperties(trip, 'comment', 'endDate', 'startDate', 'destination');

        content.pushObjects([
          {
            text: destination,
            style: 'destination',
          },
          {
            text: `From ${formatDate([startDate], { format })} to ${formatDate([endDate], { format })}`,
            style: 'dates',
          },
          {
            text: comment && comment.replace(sanitizer, ' ').replace(trimmer, ' ') || '',
            style: 'comment',
          }
        ]);
      });

      pdfMake.createPdf({ content, styles }).open();
    },
  },
});
