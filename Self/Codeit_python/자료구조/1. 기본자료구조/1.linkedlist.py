class Node:
    """ 링크드리스트의 노드 클래스"""

    def __init__(self, data):         # 노드가 생성될때 노드가 저장할 정보를 data에 받는다
        self.data = data              # 노드가 저장할 데이터
        self.next = None              # 다음 노드에 대한 레퍼런스


# # 데이터2, 3, 5, 7, 11을 담는 노드들 생성 -> 변수에 담는다
# head_node = Node(2)
# node_1 = Node(3)
# node_2 = Node(5)
# node_3 = Node(7)
# tail_node = Node(11)
#
# # 노드를 연결
# head_node.next = node_1
# node_1.next = node_2
# node_2.next = node_3
# node_3.next = tail_node
#
# # 노드 순서대로 출력
# iterator = head_node                 # iterate = 반복하다
#
# while iterator is not None:          # iterator가 None이 아닌동안 반복한다.
#     print(iterator.data)
#     iterator = iterator.next

class LinkedList:
    """ 링크드리스트 클래스"""             # 효율적인 리스트관리를 위해 생성

    def __init__(self):
        self.head = None
        self.tail = None

    def append(self, data):
        """ 링크드리스트 추가 연산 메소드"""
        new Node = Node(data)









