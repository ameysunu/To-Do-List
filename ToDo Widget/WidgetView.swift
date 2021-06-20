//
//  WidgetView.swift
//  ToDo
//
//  Created by Amey Sunu on 20/06/21.
//

import SwiftUI
import WidgetKit

struct WidgetData{
    let task: String
    let body: String
    let category: String
}

extension WidgetData{
    static let previewData = WidgetData(task: "Test", body: "7:00 PM Dinner", category: "Personal")
}

struct WidgetView: View {
    let data: WidgetData
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(data.task)
                Text(data.body)
                Text(data.category)
            }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            WidgetView(data: .previewData).previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
