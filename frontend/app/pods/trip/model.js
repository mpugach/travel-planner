import attr from 'ember-data/attr';
import Model from 'ember-data/model';

import { belongsTo } from 'ember-data/relationships';

export default Model.extend({
  userId: attr('number'),
  comment: attr('string'),
  endDate: attr('date'),
  startDate: attr('date'),
  destination: attr('string'),

  user: belongsTo('user'),
});
