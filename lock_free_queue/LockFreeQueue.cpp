#define CAS(a_ptr, a_oldVal, a_newVal) \
    __sync_bool_compare_and_swap(a_ptr, a_oldVal, a_newVal)

LockFreeQueue::LockFreeQueue() {
    head = new QueueNode(-1);
    tail = head;
}

LockFreeQueue::~LockFreeQueue() {}

// 队列空的时候有一个无用节点，插入从后插，弹出从前弹，这保证了enqueue和dequeue中的cur_node永远都不是一个节点，这样插入和弹出就肯定不存在竞争

bool LockFreeQueue::enqueue(int val) {
    LockFreeQueue* cur_node;
    LockFreeQueue* add_node = new QueueNode(val);
    while (1) {
        cur_node = tail;
        if (CAS(&(cur_node->next), NULL, add_node)) {   // 1st CAS
            break;
        } else {
            CAS(&tail, cur_node, cur_node->next);       // 2nd CAS
        }
    }
    CAS(&tail, cur_node, add_node);                     // 3rd CAS
    //第二三次CAS其实都在做一件事情，就是更新tail
    return 1;
}

int LockFreeQueue::dequeue() {
    QueueNode* cur_node;
    int val;
    while (1) {
        cur_node = head;
        if (cur_node->next == NULL) {
            return -1;
        }
        if (CAS(&head, cur_node, cur_node->next)) {
            break;
        }
    }
    val = cur_node->next->val;
    delete cur_node;
    return val;
}
