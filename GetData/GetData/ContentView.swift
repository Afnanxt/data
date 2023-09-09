//
//  ContentView.swift
//  GetData
//
//  Created by afnan saad on 22/02/1445 AH.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
//struct
struct Student:Identifiable{
    var name:String
    var id = UUID()
    
}
// class
class ViewModel:ObservableObject{
    // array from struct
    @Published var list = [Student]()
    
    func getData(){
        
        let d = Firestore.firestore()
        
        d.collection("Student").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot{

                    DispatchQueue.main.async {
                        
                        self.list = snapshot.documents.map{
                                
                                d in
                                
                                return Student(name:d["name"] as? String ?? "")
                                
                            }

                       
                           
                    }
                
                }
            }
        }
    } //get
}//class end





struct ContentView: View {
    @ObservedObject var model = ViewModel()
    var body: some View {
        VStack {
            Text("Syndrome dons")
            .padding(.trailing,160)
                .font(.title)
            Spacer()
            ScrollView{
                ForEach(model.list){ item in
                    
                   
                    
                    //.background(.green)
                    
                    ZStack{
                    Rectangle()
                    .fill(Color(red: 0.2, green: 0.1, blue: 0.7).opacity(0.6))
                    .frame(width: 370,height: 184)
                  
                    .cornerRadius(27)
                    
                        
                        Text(item.name)
                            .font(.title2)
                            .padding()
                        
                            .font(.largeTitle)
                    
                        .padding(.trailing,270)
                       
                        
                                
                            } // zstack
                    
                } // for each
            } // scroll view
        }
        // vstack
    } // view
    
    
    
    
    init(){
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
