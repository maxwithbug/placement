# A "Node" is like one box in a chain.
# Each box holds: the value, an arrow back, and an arrow forward.
class Node:
    def __init__(self, data):
        self.data = data  # the toy inside the box
        self.prev = None  # arrow pointing to the box before this one
        self.next = None  # arrow pointing to the box after this one


class DoubleLinkedList:
    def __init__(self):  # <-- must be __init__ (2 underscores each side!)
        self.head = None  # empty list = no first box yet

    def insertAtEnd(self, data):  # add a new box at the end of the chain
        temp = Node(data)  # make a new box

        if self.head is None:  # if the chain is empty...
            self.head = temp  # ...this new box becomes the first box
            return

        # otherwise, walk from the first box to the very last box
        t = self.head
        while t.next is not None:
            t = t.next  # move to the next box

        t.next = temp  # last box now points forward to new box
        temp.prev = t  # new box points backward to last box=
    
    def insertAtBeg(self,data):
        temp = None(data)
        if self.head is None:
            self.head = temp
        
        
                
        
        
        
    def printDLL(self):  # show every box's toy, in order
        t = self.head  # start at the first box
        while t is not None:
            print(t.data , end="<< -- >>")  # show the toy in this box
            t = t.next  # move to the next box


obj = DoubleLinkedList()
obj.insertAtEnd(10)
obj.insertAtEnd(20)
obj.insertAtEnd(30)
obj.insertAtEnd(40)
obj.printDLL()  # you also forgot to actually call this to see the output!
