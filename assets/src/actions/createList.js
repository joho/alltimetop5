export default function createList(context, payload, done) {
    console.log("action: createList", payload);
    let list = payload.list;
    context.dispatch('UPDATE_LIST', list);
    done();
}
