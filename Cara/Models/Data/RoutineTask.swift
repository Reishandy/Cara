//
//  RoutineTask.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

@Model
final class RoutineTask: Seedable {
	var id: UUID
	
	// FIXME: TaskIcon
	var taskName: String
	var taskIcon: String
	var howTo: [String]
	var isDefault: Bool
	
	@Attribute(.externalStorage) var image: Data?
	
	var category: TaskCategory?
	var routines: [Routine] = []
	
	init(taskName: String, taskIcon: String = "cross.fill", howTo: [String], isDefault: Bool = false, image: Data? = nil, category: TaskCategory? = nil) {
		self.id = UUID()
		self.taskName = taskName
		self.taskIcon = taskIcon
		self.howTo = howTo
		self.image = image
		self.isDefault = isDefault
		self.category = category
	}
	
	static var defaultData: [RoutineTask] {
		let physical = TaskCategory(categoryName: "Physical Rehab", isDefault: true)
		let oral = TaskCategory(categoryName: "Swallowing & Oral Exercises", isDefault: true)
		let daily = TaskCategory(categoryName: "Daily Care Essentials", isDefault: true)
		
		// FIXME: Provide default image and icon for each of these tasks
		return [
			// MARK: - Category 1: Physical Rehab
			RoutineTask(
				taskName: "Assisted Shoulder Forward Flexion (Passive ROM)",
				howTo: [
					"Have the patient lie flat on their back or sit securely in a supportive chair.",
					"Support the weak arm by cradling the elbow with one hand and holding the wrist firmly with your other hand.",
					"Crucial Safety Rule: Never pull or yank the arm from the wrist alone; always lift from the elbow.",
					"Slowly and gently raise the patient's arm forward and upward toward the ceiling.",
					"Stop immediately if the patient winces, signals pain, or if you feel sudden physical resistance.",
					"Hold at the highest comfortable point for 5 seconds, then slowly lower it back down."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Shoulder Outer Rotation (Passive ROM)",
				howTo: [
					"Have the patient lie flat on their back in bed.",
					"Place their weak arm next to their body, bend their elbow to a 90-degree angle, so their fingers point straight up at the ceiling.",
					"Hold the patient's elbow steady with one hand, and grip their wrist with your other hand.",
					"Keeping the elbow tucked tightly against their side, slowly rotate the forearm outward toward the bed sheet (like a swinging door).",
					"Hold the stretch for 5 seconds when you feel mild resistance, then return the forearm to the starting position."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Elbow Extension & Forearm Turning (Passive ROM)",
				howTo: [
					"Cradle the patient's weak elbow with one hand and hold their hand with your other hand (like shaking hands).",
					"Gently straighten the elbow out completely until the arm is lying flat.",
					"While the arm is straight, slowly turn their palm up toward the ceiling, hold for 3 seconds, then slowly turn their palm down toward the bed.",
					"Gently bend the elbow back up to a resting position."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Wrist & Finger Extension Stretch (Passive ROM)",
				howTo: [
					"Hold the patient's weak forearm just above the wrist with one hand to keep it steady.",
					"Open your other hand and interlace your fingers with the patient's fingers, flattening their hand against yours.",
					"Slowly pull their fingers back to open the hand, and gently pull the entire hand backward at the wrist joint to stretch the forearm.",
					"Hold this open, stretched position for 15 to 30 seconds to allow the stiff muscles to relax.",
					"Slowly release the stretch; never let the hand snap back into a fist rapidly."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Hand & Finger Towel Grasp (Active-Assisted)",
				howTo: [
					"Seat the patient at a flat table and place a small, rolled-up hand towel directly in front of them.",
					"Assist the patient in placing their weak hand flat next to the towel.",
					"Ask the patient to open their fingers as wide as possible using their own brain power, helping guide their fingers open if they freeze.",
					"Instruct them to wrap their fingers completely around the towel and squeeze as hard as they can for 5 seconds.",
					"Ask them to consciously relax and open their grip completely back to the flat table surface."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Assisted Hip & Knee Flexion / \"Classic Heel Slides\" (Passive ROM)",
				howTo: [
					"Have the patient lie completely flat on their back in bed.",
					"Place one hand securely behind the patient's weak knee and cup their heel with your other hand.",
					"Slowly lift the knee upward, sliding the patient's heel along the surface of the bed toward their buttocks.",
					"Continue bending the hip and knee until you feel resistance or the patient signals discomfort.",
					"Hold for 3 seconds, then slowly slide the heel back down until the leg is completely straight again."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Hip Abduction / Outward Leg Slide (Passive ROM)",
				howTo: [
					"Ensure the patient is lying flat on their back with both legs straight.",
					"Slide one hand underneath the patient’s weak ankle and place your other hand just under their knee to support the weight of the leg.",
					"Keeping the patient's toes and kneecap pointing straight up at the ceiling, slowly slide the entire leg outward away from the other leg.",
					"Move the leg outward as far as comfortable without causing their pelvis to tilt or twist.",
					"Hold for 5 seconds, then slowly slide the leg back inward to meet the strong leg."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Ankle Dorsiflexion / Calf Stretch (Passive ROM)",
				howTo: [
					"While the patient is lying down with a straight leg, cup their weak heel with the palm of your hand.",
					"Let their forearm rest flat against the bottom sole of the patient's foot.",
					"Lean forward slightly, using your forearm to push the ball of their foot upward toward their shin bone, while pulling backward on their heel.",
					"Keep pushing until you feel firm tightness in their calf muscle.",
					"Hold this deep stretch for 20 to 30 seconds, then slowly release the pressure."
				],
				isDefault: true,
				category: physical
			),
			RoutineTask(
				taskName: "Seated Ankle Taps (Active-Assisted)",
				howTo: [
					"Sit the patient upright in a sturdy chair with both feet resting flat on the floor.",
					"Ask the patient to try and lift just the toes and front half of their weak foot off the ground while keeping their heel glued to the floor.",
					"If they cannot lift it, place your hand under their toes and lightly assist them in lifting the foot upward.",
					"Hold the foot up for 2 seconds, then tell them to lower it back down under control.",
					"Have them repeat this rhythmic tapping motion to stimulate neural pathways."
				],
				isDefault: true,
				category: physical
			),
			
			// MARK: - Category 2: Swallowing & Oral Exercises
			RoutineTask(
				taskName: "Tongue In-and-Outs (Active / Active-Assisted)",
				howTo: [
					"Sit the patient completely upright at a 90-degree angle.",
					"Instruct the patient to open their mouth slightly and stick their tongue straight out as far as possible.",
					"Hold the tongue at maximum extension for 2 seconds.",
					"Instruct them to pull the tongue back into the mouth as far as possible, pulling toward the back of the throat.",
					"Hold the retracted position for 2 seconds, then rest.",
					"*Assisted Modification:* If the tongue deviates heavily to one side, the caregiver can use a clean gauze pad to gently guide it straight forward."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "Tongue Side-to-Side Movements",
				howTo: [
					"Have the patient open their mouth wide.",
					"Direct them to touch the far right corner of their lips with the tip of their tongue.",
					"Hold that position for 2 seconds.",
					"Move the tongue smoothly across to touch the far left corner of their lips.",
					"Hold on the left side for 2 seconds.",
					"Repeat the sweeping motion back and forth cleanly without letting the tongue drop to the lower teeth."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "Tongue Up-and-Down Elevation",
				howTo: [
					"Open the mouth comfortably wide.",
					"Direct the patient to raise the tip of their tongue upward toward their nose, attempting to touch the upper lip or roof of the mouth.",
					"Hold the lift for 2 seconds.",
					"Pull the tongue downward toward the chin, extending it over the lower lip.",
					"Hold the downward stretch for 2 seconds."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "Lip Purse-to-Smile Flexing",
				howTo: [
					"Instruct the patient to pucker their lips tightly forward into an exaggerated \"fish face\" or kissing shape.",
					"Hold the tight pucker for 3 seconds.",
					"Immediately transition into an ultra-wide, open smile showing their teeth.",
					"Hold the wide smile for 3 seconds, ensuring the stroke-affected side of the mouth pulls back as much as possible.",
					"Alternating smoothly between puckering and smiling builds flexibility in the orbicularis oris muscle."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "Lip Resistance Training (Caregiver Assisted)",
				howTo: [
					"Have the patient close their mouth firmly.",
					"Place a clean, flat tongue depressor or the back of a smooth, cold metal spoon against the outer center of their lips.",
					"Instruct the patient to press their lips forward against the object, trying to push it away.",
					"Apply light counter-pressure with your hand, resisting their movement.",
					"Hold this active resistance for 3 to 5 seconds, then remove the spoon and let them rest."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "Cheek Puffs (Intraoral Pressure Drill)",
				howTo: [
					"Instruct the patient to close their mouth tightly and blow air into their cheeks until they puff out like a balloon.",
					"Hold the air inside their mouth, keeping the lips sealed completely for 5 seconds.",
					"**Crucial Observation:** Check if air is leaking out of the weak side of the mouth.",
					"If air leaks, the caregiver should gently press a clean finger against the weak corner of the lips to help hold the seal.",
					"Relax, exhale, and repeat."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "Effortless Swallow / Masako Maneuver",
				howTo: [
					"Ensure the patient is sitting fully alert and upright.",
					"Stick the tip of the tongue out slightly between the front teeth.",
					"Gently bite down on the tongue to hold it securely in place.",
					"**Without releasing the tongue**, instruct the patient to swallow their own saliva.",
					"This will feel difficult and require significant throat effort. Rest for 5 seconds between each attempt.",
					"**Safety Warning:** Never perform this exercise with actual food or liquid in the mouth; do this *only* with saliva."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "The Mendelsohn Maneuver (The Adam's Apple Hold)",
				howTo: [
					"Ask the patient to swallow their saliva normally and feel their throat move up and down (the Adam's apple or larynx area).",
					"Instruct them to perform another swallow, but **consciously hold their throat up at its highest point** for 2 to 3 seconds using their throat muscles.",
					"Tell them to picture holding their breath or squeezing their throat tight mid-swallow.",
					"Release the squeeze and let the throat drop back down to its resting position."
				],
				isDefault: true,
				category: oral
			),
			RoutineTask(
				taskName: "The Chin-Tuck Setup (Postural Drill)",
				howTo: [
					"Before taking any bite or sip, ensure the patient is sitting at a 90-degree angle.",
					"Bring the food or cup to the patient's mouth.",
					"Right before they swallow, instruct them to tuck their chin down firmly toward their chest (looking down at their lap).",
					"Execute the swallow *while* the chin is tucked down.",
					"Lift the head back up only after the swallow is completely finished."
				],
				isDefault: true,
				category: oral
			),
			
			// MARK: - Category 3: Daily Care Essentials
			RoutineTask(
				taskName: "Pre-Medication Vitals Check",
				howTo: [
					"Ensure the patient has been resting quietly in a seated position for at least 5 minutes.",
					"Secure the automated blood pressure cuff onto the patient's **strong arm**, tracking the placement guidelines on the cuff.",
					"Run the machine and record the Systolic, Diastolic, and Pulse readings in the app.",
					"**Crucial Safety Rule:** If the Systolic reading is less than 100 mmHg or the Heart Rate is less than 55 bpm, hold the medication and call your home-health nurse or doctor immediately before dosing."
				],
				isDefault: true,
				category: daily
			),
			RoutineTask(
				taskName: "Scheduled Medication Administration",
				howTo: [
					"Cross-reference your pill organizer with the active prescription labels to ensure zero duplicates.",
					"Sit the patient completely upright at a 90-degree angle to prevent choking.",
					"Administer pills one at a time, using the prescribed liquid consistency (e.g., honey-thickened water) or hiding them in applesauce/puree if swallowing thin liquids is restricted.",
					"Have the patient open their mouth wide after swallowing to visually verify that pills aren't \"pocketed\" or hidden inside their weak cheek."
				],
				isDefault: true,
				category: daily
			),
			RoutineTask(
				taskName: "Safe Assisted Showering",
				howTo: [
					"Transfer the patient into a dedicated, slip-resistant shower chair placed inside the basin. Securely fasten any safety straps.",
					"Set the water temperature and test it yourself on your inner wrist first; stroke survivors often have altered temperature sensation and can burn easily without realizing it.",
					"Hand the soapy washcloth to the patient's **strong hand** and encourage them to wash their face, chest, and strong arm independently to preserve dignity and neural function.",
					"Guide and support the patient to gently wash their weak side, paying special attention to washing and thoroughly drying skin folds (under-arms, groin) to prevent fungal infections."
				],
				isDefault: true,
				category: daily
			),
			RoutineTask(
				taskName: "Assisted Sink Grooming (Oral & Shaving)",
				howTo: [
					"Wheel or guide the patient to the sink, ensuring their feet are flat and stable on the floor or footrests.",
					"Apply toothpaste or grooming cream using adaptive, wide-grip tools if available.",
					"Stand closely on the patient's **weak side** to act as a physical stabilizer in case they lose their trunk balance and lean over.",
					"Guide them to use their strong hand to complete the tasks, using a mirror to provide visual feedback to their brain for orientation."
				],
				isDefault: true,
				category: daily
			),
			RoutineTask(
				taskName: "Structured Orientation & Reality Check",
				howTo: [
					"Sit face-to-face with the patient in a well-lit room free of background noise (turn off the TV).",
					"Ask the patient open-ended questions: \"Do you know what day of the week it is?\", \"What season are we in right now?\", or \"Where are we currently sitting?\"",
					"If they struggle or guess incorrectly, gently redirect them using visual cues: point to a large-text calendar, a clock, or look out the window together.",
					"Spend 5 minutes discussing a familiar family memory or checking a daily photo journal to stimulate neural recall pathways."
				],
				isDefault: true,
				category: daily
			),
			RoutineTask(
				taskName: "Evening Wind-Down & Sundowning Prevention",
				howTo: [
					"Eliminate harsh overhead lighting and transition to warm, dim lamps 2 hours before the target bedtime.",
					"Shut off loud, chaotic media or news programs; switch to soft ambient music or total silence.",
					"Offer a light, easily digestible snack that conforms to their safe texture guidelines to prevent midnight hunger spikes.",
					"Confirm that the patient uses the restroom one final time right before getting into bed to reduce midnight waking and disorientation."
				],
				isDefault: true,
				category: daily
			)
		]
	}
}
