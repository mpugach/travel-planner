import Ember from 'ember';
import moment from 'moment';

const {
  Helper: {
    helper,
  },
} = Ember;

export function startsIn([value]) {
  if (!value) return null;

  const today = moment().startOf('day');
  const targetDate = moment(value).startOf('day');

  if (targetDate.diff(today, 'days') < 1) return null;

  return `(starts in ${targetDate.fromNow(today)})`;
}

export default helper(startsIn);
