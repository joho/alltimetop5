export default function fetchList(context, payload, done) {
  // for now, pretend we have talked to a server;
  const list = [
    'Empire Strikes Back',
    'A New Hope',
    'The Force Awakens',
    'Return of the Jedi',
    'Revenge of the Sith'
  ]

  context.dispatch('UPDATE_LIST', list);
  done();
}
