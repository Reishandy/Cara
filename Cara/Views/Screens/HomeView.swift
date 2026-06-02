//
//  HomeView.swift
//  CH3-PM-Team4
//
//  Created by Fadil Himawan on 29/05/26.
//


import SwiftUI

struct HomeView: View {
    
	var body: some View {
		ScrollView {
                HStack {
                    Text("26 May 2026")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding(16)
                .background(Color.background)
                .cornerRadius(26)
                .foregroundStyle(.appPrimary)
                
                RoutineCard(routine:
                                Routine(
                                    routineName: "Morning Routine", routineDescription: "Bebas bg", tasks: [])
                )
			
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(16)
		// .navigationTitle("Caregiving")
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Text("Caregiving")
					.foregroundStyle(Color.primary)
			}
			
			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					// do nothing
				} label: {
					Image(systemName: "plus")
				}
			}
		}
	}
	
}

#Preview {
	HomeView()
}

struct RoutineCard: View {
    let routine: Routine
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Daily Routine")
                .font(.title)
                .bold()
                .foregroundStyle(.appPrimary)
            
            RoutineBody(routine: routine)
        }
    }
}

private struct RoutineBody: View {
    let routine: Routine
    
    var finishedTasks: [Task] {
        routine.tasks.filter { (task) -> Bool in
            task.isDefault
        }
    }
    
    var body: some View {
        NavigationLink(
            value: Screen.routineDetail
        ) {
            VStack(alignment: .leading) {
                HStack {
                    CircularProgressRing(
                        total: routine.tasks.count,
                        done: finishedTasks.count)
                    
                    Spacer().frame(width: 24)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(routine.routineName)
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.appPrimary)
                            Text("Best time: 05:00 - 11:59")
                                .font(.subheadline)
                                .foregroundStyle(.appThird)
                            
                            HStack {
                                ForEach(0..<routine.tasks.count) { _ in
                                    Circle()
                                        .foregroundStyle(.appThird)
                                        .frame(width: 28)
                                }
                                
                                Text("+3")
                                    .foregroundStyle(.appThird)
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.appThird)
                    }
                }
                
                Spacer().frame(height: 16)
                
                HStack {
                    ForEach(0..<4) { _ in
                        VStack {
                            Image(
                                systemName: "square.and.arrow.down.badge.xmark.fill"
                            )
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.appPrimary)
                            Text("120/80")
                                .foregroundStyle(.appPrimary)
                                .bold()
                            Text("mm Hg")
                                .foregroundStyle(.appPrimary)
                        }
                        .padding(8)
                        .background(.appFourth)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                
                Spacer().frame(height: 16)
                
                // FIXME: change to note property
                if routine.histories.count != nil {
                    HStack {
                        Image(systemName: "text.pad.header")
                        Spacer()
                            .frame(width: 6)
                        Text("Mom is not happy")
                    }
                    .foregroundStyle(.appThird)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(Color.secondaryBackground)
            .cornerRadius(13)
        }
    }
}

// FIXME: Move to components
struct CircularProgressRing: View {
    let total: Int
    let done: Int
	
	var body: some View {
		ZStack {
			// inactive part
			Circle()
				.stroke(
					Color.gray.opacity(0.25),
					lineWidth: 12
				)
			
			// active part
            let progress = total == 0 ? 0 : CGFloat(done) / CGFloat(total)
			Circle()
                .trim(from: 0, to: progress)
				.stroke(
					Color.appPrimary,
					style: StrokeStyle(
						lineWidth: 12,
						lineCap: .round
					)
				)
				.rotationEffect(.degrees(-90))
            
            Text("\(done)/\(total)")
                .foregroundStyle(.appPrimary)
		}
		.frame(width: 55, height: 55)
	}
}
