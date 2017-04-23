export function initialize(application) {
  application.inject('route', 'session', 'service:session');
  application.inject('controller', 'session', 'service:session');
  application.inject('service:ajax', 'session', 'service:session');
  application.inject('service:current-user', 'session', 'service:session');
}

export default {
  name: 'session',
  initialize
};
