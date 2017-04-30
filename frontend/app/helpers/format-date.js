import Ember from 'ember';
import moment from 'moment';

const {
  Helper: {
    helper,
  },
} = Ember;

export function formatDate([value, ...rest], namedOptions) {
  if (!value) return null;

  return moment(value).format(namedOptions.format);
}

export default helper(formatDate);
