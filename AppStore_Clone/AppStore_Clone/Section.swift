import UIKit

enum Section {
  case Today([TodayModel])
  case recentDays([RecentDataModel])
  case lastSummary([SummaryModel])
  case noData([NoDataModel])
}

struct TodayModel {
  let title: String
  let date: String
  let bpm: String
}

struct RecentDataModel {
  let title: String
  let date: String
  let description: String
}

struct SummaryModel {
  let title: String
  let date: String
  let description: String
}

struct NoDataModel {
  let title: String
}
