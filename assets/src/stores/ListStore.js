import { BaseStore } from 'fluxible/addons';

class ListStore extends BaseStore {
  constructor(dispatcher) {
    super(dispatcher);

    this.dispatcher = dispatcher;
    this.list = null;
  }

  getList() {
    return this.list;
  }

  handleUpdateList(list) {
    console.log("store: handleUpdateList", list);
    this.list = list;
    this.emitChange();
  }
}

ListStore.storeName = 'ListStore';
ListStore.handlers = {
  ['UPDATE_LIST']: 'handleUpdateList',
};

export default ListStore;
