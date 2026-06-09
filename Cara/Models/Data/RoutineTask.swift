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
	
	var taskName: String
	var taskDescription: String
	var taskIcon: String
	var howTo: [String]
	var isDefault: Bool
	
	var imageSystemName: String?
	@Attribute(.externalStorage) var image: Data?
	
	var category: TaskCategory?
	var routines: [Routine] = []
	
	init(taskName: String, taskDescription: String, taskIcon: String = "cross.fill", howTo: [String], isDefault: Bool = false, imageSystemName: String? = nil, image: Data? = nil, category: TaskCategory? = nil) {
		self.id = UUID()
		self.taskName = taskName
		self.taskDescription = taskDescription
		self.taskIcon = taskIcon
		self.howTo = howTo
		self.imageSystemName = imageSystemName
		self.image = image
		self.isDefault = isDefault
		self.category = category
	}
	
	static var defaultData: [RoutineTask] {
		let physical = TaskCategory(categoryName: "Physical Rehab", isDefault: true)
		let oral = TaskCategory(categoryName: "Swallowing & Oral Exercises", isDefault: true)
		let daily = TaskCategory(categoryName: "Daily Care Essentials", isDefault: true)
		let mobility = TaskCategory(categoryName: "Mobility Support & Safe Transfers", isDefault: true)
		let skin = TaskCategory(categoryName: "Skin Integrity & Pressure Management", isDefault: true)
		let ngt = TaskCategory(categoryName: "Nasogastric Tube (NGT) Management & Feeding", isDefault: true)
		let trach = TaskCategory(categoryName: "Advanced Tracheostomy Support & Airway Clearing", isDefault: true)
		
		return [
			// MARK: - Category 1: Physical Rehab
            RoutineTask(
                    taskName: "Assisted Shoulder Forward Flexion (Passive ROM)",
                    taskDescription: "Keeps the shoulder joint loose and prevents painful stiffening (frozen shoulder) on the paralyzed side.",
                    taskIcon: "figure.dance",
                    howTo: [
                        "Have the patient lie flat on their back or sit securely in a supportive chair.",
                        "Support the weak arm by cradling the elbow with one hand and holding the wrist firmly with your other hand.",
                        "Crucial Safety Rule: Never pull or yank the arm from the wrist alone; always lift from the elbow.",
                        "Slowly and gently raise the patient's arm forward and upward toward the ceiling.",
                        "Stop immediately if the patient winces, signals pain, or if you feel sudden physical resistance.",
                        "Hold at the highest comfortable point for 5 seconds, then slowly lower it back down."
                    ],
                    isDefault: true,
                    imageSystemName: "physical1",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Shoulder Outer Rotation (Passive ROM)",
                    taskDescription: "Rotates the shoulder joint outward to maintain the flexibility needed for dressing and hygiene.",
                    taskIcon: "figure.dance",
                    howTo: [
                        "Have the patient lie flat on their back in bed.",
                        "Place their weak arm next to their body, bend their elbow to a 90-degree angle, so their fingers point straight up at the ceiling.",
                        "Hold the patient's elbow steady with one hand, and grip their wrist with your other hand.",
                        "Keeping the elbow tucked tightly against their side, slowly rotate the forearm outward toward the bed sheet (like a swinging door).",
                        "Hold the stretch for 5 seconds when you feel mild resistance, then return the forearm to the starting position."
                    ],
                    isDefault: true,
                    imageSystemName: "physical2",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Elbow Extension & Forearm Turning (Passive ROM)",
                    taskDescription: "Straightens the elbow and rotates the forearm to prevent muscles from shortening into a permanent bend.",
                    taskIcon: "figure.dance",
                    howTo: [
                        "Cradle the patient's weak elbow with one hand and hold their hand with your other hand (like shaking hands).",
                        "Gently straighten the elbow out completely until the arm is lying flat.",
                        "While the arm is straight, slowly turn their palm up toward the ceiling, hold for 3 seconds, then slowly turn their palm down toward the bed.",
                        "Gently bend the elbow back up to a resting position."
                    ],
                    isDefault: true,
                    imageSystemName: "physical3",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Wrist & Finger Extension Stretch (Passive ROM)",
                    taskDescription: "Opens the wrist and fingers to counteract \"flexor spasticity\" (the natural tendency for a stroke-affected hand to curl into a tight fist).",
                    taskIcon: "hand.raised.fill",
                    howTo: [
                        "Hold the patient's weak forearm just above the wrist with one hand to keep it steady.",
                        "Open your other hand and interlace your fingers with the patient's fingers, flattening their hand against yours.",
                        "Slowly pull their fingers back to open the hand, and gently pull the entire hand backward at the wrist joint to stretch the forearm.",
                        "Hold this open, stretched position for 15 to 30 seconds to allow the stiff muscles to relax.",
                        "Slowly release the stretch; never let the hand snap back into a fist rapidly."
                    ],
                    isDefault: true,
                    imageSystemName: "physical4",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Hand & Finger Towel Grasp (Active-Assisted)",
                    taskDescription: "Retrains grip strength and neural connection by forcing the fingers on the weak hand to open and squeeze intentionally.",
                    taskIcon: "hand.raised.fill",
                    howTo: [
                        "Seat the patient at a flat table and place a small, rolled-up hand towel directly in front of them.",
                        "Assist the patient in placing their weak hand flat next to the towel.",
                        "Ask the patient to open their fingers as wide as possible using their own brain power, helping guide their fingers open if they freeze.",
                        "Instruct them to wrap their fingers completely around the towel and squeeze as hard as they can for 5 seconds.",
                        "Ask them to consciously relax and open their grip completely back to the flat table surface."
                    ],
                    isDefault: true,
                    imageSystemName: "physical5",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Assisted Hip & Knee Flexion / \"Classic Heel Slides\" (Passive ROM)",
                    taskDescription: "Moves the hip and knee joints together to prevent stiffness and prepare the lower body for eventually walking again.",
                    taskIcon: "figure.walk",
                    howTo: [
                        "Have the patient lie completely flat on their back in bed.",
                        "Place one hand securely behind the patient's weak knee and cup their heel with your other hand.",
                        "Slowly lift the knee upward, sliding the patient's heel along the surface of the bed toward their buttocks.",
                        "Continue bending the hip and knee until you feel resistance or the patient signals discomfort.",
                        "Hold for 3 seconds, then slowly slide the heel back down until the leg is completely straight again."
                    ],
                    isDefault: true,
                    imageSystemName: "physical6",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Hip Abduction / Outward Leg Slide (Passive ROM)",
                    taskDescription: "Moves the leg sideways to keep the inner thigh muscles flexible, which is essential for safe transfers and using the bathroom.",
                    taskIcon: "figure.walk",
                    howTo: [
                        "Ensure the patient is lying flat on their back with both legs straight.",
                        "Slide one hand underneath the patient’s weak ankle and place your other hand just under their knee to support the weight of the leg.",
                        "Keeping the patient's toes and kneecap pointing straight up at the ceiling, slowly slide the entire leg outward away from the other leg.",
                        "Move the leg outward as far as comfortable without causing their pelvis to tilt or twist.",
                        "Hold for 5 seconds, then slowly slide the leg back inward to meet the strong leg."
                    ],
                    isDefault: true,
                    imageSystemName: "physical7",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Ankle Dorsiflexion / Calf Stretch (Passive ROM)",
                    taskDescription: "Stretches the Achilles tendon to treat or prevent \"drop-foot\" (where the toes drag on the ground, causing severe tripping hazards).",
                    taskIcon: "figure.walk",
                    howTo: [
                        "While the patient is lying down with a straight leg, cup their weak heel with the palm of your hand.",
                        "Let their forearm rest flat against the bottom sole of the patient's foot.",
                        "Lean forward slightly, using your forearm to push the ball of their foot upward toward their shin bone, while pulling backward on their heel.",
                        "Keep pushing until you feel firm tightness in their calf muscle.",
                        "Hold this deep stretch for 20 to 30 seconds, then slowly release the pressure."
                    ],
                    isDefault: true,
                    imageSystemName: "physical8",
                    category: physical
                ),
                RoutineTask(
                    taskName: "Seated Ankle Taps (Active-Assisted)",
                    taskDescription: "A cognitive-motor drill to help the brain reconnect with the muscles on the front of the shin that lift the foot.",
                    taskIcon: "figure.walk",
                    howTo: [
                        "Sit the patient upright in a sturdy chair with both feet resting flat on the floor.",
                        "Ask the patient to try and lift just the toes and front half of their weak foot off the ground while keeping their heel glued to the floor.",
                        "If they cannot lift it, place your hand under their toes and lightly assist them in lifting the foot upward.",
                        "Hold the foot up for 2 seconds, then tell them to lower it back down under control.",
                        "Have them repeat this rhythmic tapping motion to stimulate neural pathways."
                    ],
                    isDefault: true,
                    imageSystemName: "physical9",
                    category: physical
                ),
			
			// MARK: - Category 2: Swallowing & Oral Exercises
            RoutineTask(
                    taskName: "Tongue In-and-Outs (Active / Active-Assisted)",
                    taskDescription: "Builds forward and backward tongue strength required to initiate a clean, safe swallow.",
                    taskIcon: "mouth",
                    howTo: [
                        "Sit the patient completely upright at a 90-degree angle.",
                        "Instruct the patient to open their mouth slightly and stick their tongue straight out as far as possible.",
                        "Hold the tongue at maximum extension for 2 seconds.",
                        "Instruct them to pull the tongue back into the mouth as far as possible, pulling toward the back of the throat.",
                        "Hold the retracted position for 2 seconds, then rest.",
                        "Assisted Modification: If the tongue deviates heavily to one side, the caregiver can use a clean gauze pad to gently guide it straight forward."
                    ],
                    isDefault: true,
                    imageSystemName: "oral1",
                    category: oral
                ),
                RoutineTask(
                    taskName: "Tongue Side-to-Side Movements",
                    taskDescription: "Trains the lateral coordination needed to manipulate food chunks and prevent choking.",
                    taskIcon: "mouth",
                    howTo: [
                        "Have the patient open their mouth wide.",
                        "Direct them to touch the far right corner of their lips with the tip of their tongue.",
                        "Hold that position for 2 seconds.",
                        "Move the tongue smoothly across to touch the far left corner of their lips.",
                        "Hold on the left side for 2 seconds.",
                        "Repeat the sweeping motion back and forth cleanly without letting the tongue drop to the lower teeth."
                    ],
                    isDefault: true,
                    imageSystemName: "oral2",
                    category: oral
                ),
                RoutineTask(
                    taskName: "Tongue Up-and-Down Elevation",
                    taskDescription: "Strengthens the top of the tongue to push food upward against the hard palate before swallowing.",
                    taskIcon: "mouth",
                    howTo: [
                        "Open the mouth comfortably wide.",
                        "Direct the patient to raise the tip of their tongue upward toward their nose, attempting to touch the upper lip or roof of the mouth.",
                        "Hold the lift for 2 seconds.",
                        "Pull the tongue downward toward the chin, extending it over the lower lip.",
                        "Hold the downward stretch for 2 seconds."
                    ],
                    isDefault: true,
                    imageSystemName: "oral3",
                    category: oral
                ),
                RoutineTask(
                    taskName: "Lip Purse-to-Smile Flexing",
                    taskDescription: "Builds lip elasticity and closure strength to eliminate drooling and improve speech clarity.",
                    taskIcon: "face.smiling",
                    howTo: [
                        "Instruct the patient to pucker their lips tightly forward into an exaggerated \"fish face\" or kissing shape.",
                        "Hold the tight pucker for 3 seconds.",
                        "Immediately transition into an ultra-wide, open smile showing their teeth.",
                        "Hold the wide smile for 3 seconds, ensuring the stroke-affected side of the mouth pulls back as much as possible.",
                        "Alternating smoothly between puckering and smiling builds flexibility in the orbicularis oris muscle."
                    ],
                    isDefault: true,
                    imageSystemName: "oral4",
                    category: oral
                ),
                RoutineTask(
                    taskName: "Lip Resistance Training (Caregiver Assisted)",
                    taskDescription: "Directly builds tone on the paralyzed side of the lip using physical counter-pressure.",
                    taskIcon: "hand.point.up",
                    howTo: [
                        "Have the patient close their mouth firmly.",
                        "Place a clean, flat tongue depressor or the back of a smooth, cold metal spoon against the outer center of their lips.",
                        "Instruct the patient to press their lips forward against the object, trying to push it away.",
                        "Apply light counter-pressure with your hand, resisting their movement.",
                        "Hold this active resistance for 3 to 5 seconds, then remove the spoon and let them rest."
                    ],
                    isDefault: true,
                    imageSystemName: "oral5",
                    category: oral
                ),
                RoutineTask(
                    taskName: "Cheek Puffs (Intraoral Pressure Drill)",
                    taskDescription: "Strengthens the cheek muscles (buccinator) to keep food from getting trapped between the teeth and gums.",
                    taskIcon: "face.smiling",
                    howTo: [
                        "Instruct the patient to close their mouth tightly and blow air into their cheeks until they puff out like a balloon.",
                        "Hold the air inside their mouth, keeping the lips sealed completely for 5 seconds.",
                        "Crucial Observation: Check if air is leaking out of the weak side of the mouth.",
                        "If air leaks, the caregiver should gently press a clean finger against the weak corner of the lips to help hold the seal.",
                        "Relax, exhale, and repeat."
                    ],
                    isDefault: true,
                    imageSystemName: "oral6",
                    category: oral
                ),
                RoutineTask(
                    taskName: "Effortless Swallow / Masako Maneuver",
                    taskDescription: "Forces the back wall of the throat forward to compensate for weak base-of-tongue movement, protecting the airway.",
                    taskIcon: "waveform.path.ecg",
                    howTo: [
                        "Ensure the patient is sitting fully alert and upright.",
                        "Stick the tip of the tongue out slightly between the front teeth.",
                        "Gently bite down on the tongue to hold it securely in place.",
                        "Without releasing the tongue, instruct the patient to swallow their own saliva.",
                        "This will feel difficult and require significant throat effort. Rest for 5 seconds between each attempt.",
                        "Safety Warning: Never perform this exercise with actual food or liquid in the mouth; do this only with saliva."
                    ],
                    isDefault: true,
                    imageSystemName: "oral7",
                    category: oral
                ),
                RoutineTask(
                    taskName: "The Mendelsohn Maneuver (The Adam's Apple Hold)",
                    taskDescription: "Keeps the throat open longer during a swallow, giving food more time to pass safely into the stomach without dropping into the lungs.",
                    taskIcon: "waveform.path.ecg",
                    howTo: [
                        "Ask the patient to swallow their saliva normally and feel their throat move up and down (the Adam's apple or larynx area).",
                        "Instruct them to perform another swallow, but consciously hold their throat up at its highest point for 2 to 3 seconds using their throat muscles.",
                        "Tell them to picture holding their breath or squeezing their throat tight mid-swallow.",
                        "Release the squeeze and let the throat drop back down to its resting position."
                    ],
                    isDefault: true,
                    imageSystemName: "oral8",
                    category: oral
                ),
                RoutineTask(
                    taskName: "The Chin-Tuck Setup (Postural Drill)",
                    taskDescription: "A physical positioning technique that physically narrows the entrance to the airway, dramatically reducing silent aspiration risks during meals.",
                    taskIcon: "arrow.down.to.line",
                    howTo: [
                        "Before taking any bite or sip, ensure the patient is sitting at a 90-degree angle.",
                        "Bring the food or cup to the patient's mouth.",
                        "Right before they swallow, instruct them to tuck their chin down firmly toward their chest (looking down at their lap).",
                        "Execute the swallow while the chin is tucked down.",
                        "Lift the head back up only after the swallow is completely finished."
                    ],
                    isDefault: true,
                    imageSystemName: "oral9",
                    category: oral
                ),
			
			// MARK: - Category 3: Daily Care Essentials
            RoutineTask(
                    taskName: "Pre-Medication Vitals Check",
                    taskDescription: "Logging critical safety numbers (Blood Pressure/Heart Rate) before administering potent cardiovascular medications.",
                    taskIcon: "heart.text.square.fill",
                    howTo: [
                        "Ensure the patient has been resting quietly in a seated position for at least 5 minutes.",
                        "Secure the automated blood pressure cuff onto the patient's strong arm, tracking the placement guidelines on the cuff.",
                        "Run the machine and record the Systolic, Diastolic, and Pulse readings in the app.",
                        "Crucial Safety Rule: If the Systolic reading is less than 100 mmHg or the Heart Rate is less than 55 bpm, hold the medication and call your home-health nurse or doctor immediately before dosing."
                    ],
                    isDefault: true,
                    imageSystemName: "daily1",
                    category: daily
                ),
                RoutineTask(
                    taskName: "Scheduled Medication Administration",
                    taskDescription: "Safely organizing and verifying the intake of daily stroke prevention and management prescriptions.",
                    taskIcon: "pills.fill",
                    howTo: [
                        "Cross-reference your pill organizer with the active prescription labels to ensure zero duplicates.",
                        "Sit the patient completely upright at a 90-degree angle to prevent choking.",
                        "Administer pills one at a time, using the prescribed liquid consistency (e.g., honey-thickened water) or hiding them in applesauce/puree if swallowing thin liquids is restricted.",
                        "Have the patient open their mouth wide after swallowing to visually verify that pills aren't \"pocketed\" or hidden inside their weak cheek."
                    ],
                    isDefault: true,
                    imageSystemName: "daily2",
                    category: daily
                ),
                RoutineTask(
                    taskName: "Safe Assisted Showering",
                    taskDescription: "A highly structured routine for bathing a patient with one-sided weakness while minimizing catastrophic slip-and-fall risks.",
                    taskIcon: "shower.fill",
                    howTo: [
                        "Transfer the patient into a dedicated, slip-resistant shower chair placed inside the basin. Securely fasten any safety straps.",
                        "Set the water temperature and test it yourself on your inner wrist first; stroke survivors often have altered temperature sensation and can burn easily without realizing it.",
                        "Hand the soapy washcloth to the patient's strong hand and encourage them to wash their face, chest, and strong arm independently to preserve dignity and neural function.",
                        "Guide and support the patient to gently wash their weak side, paying special attention to washing and thoroughly drying skin folds (under-arms, groin) to prevent fungal infections."
                    ],
                    isDefault: true,
                    imageSystemName: "daily3",
                    category: daily
                ),
                RoutineTask(
                    taskName: "Assisted Sink Grooming (Oral & Shaving)",
                    taskDescription: "Morning routine at the bathroom sink designed to promote independence while protecting the weak side.",
                    taskIcon: "comb.fill",
                    howTo: [
                        "Wheel or guide the patient to the sink, ensuring their feet are flat and stable on the floor or footrests.",
                        "Apply toothpaste or grooming cream using adaptive, wide-grip tools if available.",
                        "Stand closely on the patient's weak side to act as a physical stabilizer in case they lose their trunk balance and lean over.",
                        "Guide them to use their strong hand to complete the tasks, using a mirror to provide visual feedback to their brain for orientation."
                    ],
                    isDefault: true,
                    imageSystemName: "daily4",
                    category: daily
                ),
                RoutineTask(
                    taskName: "Structured Orientation & Reality Check",
                    taskDescription: "A brief morning cognitive drill to combat post-stroke confusion, memory lapses, and environmental disorientation.",
                    taskIcon: "calendar",
                    howTo: [
                        "Sit face-to-face with the patient in a well-lit room free of background noise (turn off the TV).",
                        "Ask the patient open-ended questions: \"Do you know what day of the week it is?\", \"What season are we in right now?\", or \"Where are we currently sitting?\"",
                        "If they struggle or guess incorrectly, gently redirect them using visual cues: point to a large-text calendar, a clock, or look out the window together.",
                        "Spend 5 minutes discussing a familiar family memory or checking a daily photo journal to stimulate neural recall pathways."
                    ],
                    isDefault: true,
                    imageSystemName: "daily5",
                    category: daily
                ),
                RoutineTask(
                    taskName: "Evening Wind-Down & Sundowning Prevention",
                    taskDescription: "A strict sensory-reduction routine to prevent late-day confusion, anxiety, and aggressive behavior (sundowning) common in neurological recovery.",
                    taskIcon: "moon.stars.fill",
                    howTo: [
                        "Eliminate harsh overhead lighting and transition to warm, dim lamps 2 hours before the target bedtime.",
                        "Shut off loud, chaotic media or news programs; switch to soft ambient music or total silence.",
                        "Offer a light, easily digestible snack that conforms to their safe texture guidelines to prevent midnight hunger spikes.",
                        "Confirm that the patient uses the restroom one final time right before getting into bed to reduce midnight waking and disorientation."
                    ],
                    isDefault: true,
                    imageSystemName: "daily6",
                    category: daily
                ),
            
			// MARK: - Category 4: Mobility Support & Safe Transfers
            RoutineTask(
                    taskName: "Bed-to-Chair Stand Pivot Transfer",
                    taskDescription: "Safely moving a patient with one-sided weakness from the edge of the bed into a wheelchair or sturdy chair.",
                    taskIcon: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill",
                    howTo: [
                        "Lock the wheelchair brakes and place the chair at a 45-degree angle directly next to the bed, facing the patient's strong side.",
                        "Assist the patient into a seated position on the edge of the bed with their feet flat on the floor, slightly apart.",
                        "Place your feet outside of the patient's feet, and block their weak knee with your own knee to keep it from buckling.",
                        "Place your hands firmly around the patient's torso or hips (never pull on their weak arm or under their armpits).",
                        "On the count of three, rock forward and help the patient bear weight through their strong leg to stand up.",
                        "Pivot together on their strong foot until their backside faces the chair, then slowly lower them into the seat."
                    ],
                    isDefault: true,
                    imageSystemName: "mobility1",
                    category: mobility
                ),
                RoutineTask(
                    taskName: "Log Roll Bed Turn",
                    taskDescription: "Turning a non-ambulatory patient onto their side in bed without twisting their spine or pinching their weak shoulder.",
                    taskIcon: "arrow.2.squarepath",
                    howTo: [
                        "Cross the patient's weak arm gently across their chest so it doesn't get trapped or dragged underneath them during the turn.",
                        "Bend the patient's knee on the opposite side of the direction you want them to turn (the leg furthest from you).",
                        "Stand on the side of the bed toward which the patient will be turning.",
                        "Place one of your hands securely on the patient's far shoulder and your other hand on their far hip.",
                        "In one smooth, synchronous motion, roll the patient toward you onto their side like a solid log.",
                        "Tuck a supportive pillow behind their back and another between their knees to hold the position safely."
                    ],
                    isDefault: true,
                    imageSystemName: "mobility2",
                    category: mobility
                ),
                RoutineTask(
                    taskName: "Boosting a Patient Up in Bed (Two-Person Draw-Sheet Method)",
                    taskDescription: "Moving a patient up toward the pillows after they have slid down, avoiding skin-tearing friction.",
                    taskIcon: "arrow.up.square.fill",
                    howTo: [
                        "Lower the head of the bed completely flat and remove the patient's pillows.",
                        "Ensure the patient is lying flat on a friction-reducing draw-sheet (or a folded bed sheet placed under their torso).",
                        "Stand on opposite sides of the bed, facing each other, near the patient's upper body.",
                        "Roll up the edges of the draw-sheet close to the patient's body, grasping it firmly with an palms-up grip.",
                        "Shift your weight from your back foot to your front foot, and on the count of three, lift and slide the sheet and patient smoothly up toward the head of the bed together."
                    ],
                    isDefault: true,
                    imageSystemName: "mobility3",
                    category: mobility
                ),
                RoutineTask(
                    taskName: "Assisted Sitting Edge-of-Bed Balance",
                    taskDescription: "A static core drill to help the brain rebuild trunk control and upright spatial orientation.",
                    taskIcon: "alignment.vertical.center.fill",
                    howTo: [
                        "Assist the patient to sit up straight on the edge of the bed with their feet fully supported flat on the floor or a stool.",
                        "Stand closely on the patient’s weak side, ready to act as a physical stabilizer if they lean or fall over.",
                        "Encourage the patient to hold themselves upright without using their strong hand for support if possible.",
                        "Have them maintain this upright posture for 1 to 3 minutes, tracking whether they lean heavily toward their weak side (known as \"Pusher Syndrome\")."
                    ],
                    isDefault: true,
                    imageSystemName: "mobility4",
                    category: mobility
                ),
            
			// MARK: - Category 5: Skin Integrity & Pressure Management
            RoutineTask(
                    taskName: "Sacrum & Heel Visual Pressure Check",
                    taskDescription: "Daily visual inspection of high-risk contact points to spot and stop bedsores before the skin breaks open.",
                    taskIcon: "eye.fill",
                    howTo: [
                        "Roll the patient onto their side to fully expose the tailbone (sacrum) and lower buttocks.",
                        "Check the skin thoroughly under a bright light, looking for localized redness, purple discoloration, or a change in skin temperature/stiffness.",
                        "Press your finger firmly onto any red area; if it does not turn briefly white when pressed (non-blanching erythema), a bedsore is actively forming.",
                        "Check both heels, looking closely for deep redness, clear blisters, or skin peeling.",
                        "Action Step: If any un-blanching redness is found, log it immediately and use pillows to lift that specific body part entirely off the mattress surface."
                    ],
                    isDefault: true,
                    imageSystemName: "skin1",
                    category: skin
                ),
                RoutineTask(
                    taskName: "The 2-Hour Side-to-Side Position Rotation",
                    taskDescription: "Systematically changing the patient's body orientation every 2 hours to redistribute blood flow and relieve compressed tissue.",
                    taskIcon: "clock.fill",
                    howTo: [
                        "Log the patient's starting position (e.g., Supine / Flat on back).",
                        "Exactly 2 hours later, use the Log Roll technique to turn the patient onto their Right Side at a 30-degree tilt.",
                        "Tuck a pillow under their left hip and back, and place a pillow between their knees so their bony joints don't rub together.",
                        "After another 2 hours, rotate them back to their back, or onto their Left Side.",
                        "Crucial Safety Rule: If a specific side of the body is already showing red, un-blanching pressure marks, skip that side entirely in the rotation until the color returns to normal."
                    ],
                    isDefault: true,
                    imageSystemName: "skin2",
                    category: skin
                ),
                RoutineTask(
                    taskName: "Heel Floating & Offloading Setup",
                    taskDescription: "Completely suspending the heels in the air to prevent painful, deep-tissue pressure injuries while lying down.",
                    taskIcon: "waveform",
                    howTo: [
                        "Position the patient flat on their back in bed.",
                        "Take a firm, standard bed pillow and place it crosswise under the patient's lower legs (calves).",
                        "Position the pillow so it ends just above the ankles.",
                        "Visually verify that the patient's heels are completely suspended (\"floating\") in the air and are not touching the mattress or the sheet at all.",
                        "Ensure the knees are slightly bent to avoid hypension strain on the joints."
                    ],
                    isDefault: true,
                    imageSystemName: "skin3",
                    category: skin
                ),
                RoutineTask(
                    taskName: "Skin Shear Prevention During Adjustments",
                    taskDescription: "Techniques to prevent the skin from dragging and tearing across bed sheets when the head of the bed is elevated.",
                    taskIcon: "hand.raised.slash.fill",
                    howTo: [
                        "Before raising the head of the bed, always elevate the patient's knees slightly first (if using an adjustable hospital bed). This stops their hips from sliding forward.",
                        "Slowly raise the head of the bed, keeping the angle below 30 degrees whenever they are resting to minimize pressure on the tailbone.",
                        "If you must adjust their clothes or sheets, gently lift their body weight up rather than pulling or dragging them across the fabric."
                    ],
                    isDefault: true,
                    imageSystemName: "skin4",
                    category: skin
                ),
            
			// MARK: - Category 6: Nasogastric Tube (NGT) Management & Feeding
            RoutineTask(
                    taskName: "Pre-Feeding Tube Verification & Residual Check",
                    taskDescription: "Testing the placement of the tube and checking stomach contents to prevent accidental lung flooding.",
                    taskIcon: "checkmark.shield.fill",
                    howTo: [
                        "Elevate the bed head so the patient is sitting upright at a minimum of a 30 to 45-degree angle.",
                        "Check the external markings on the tube at the nose to ensure it hasn't slipped outward.",
                        "Attach a large 60 mL syringe to the tube port and gently pull back on the plunger to draw out stomach fluid.",
                        "The Safe Limit Rule: If you pull back more than 100 mL to 150 mL of undigested liquid formula from the previous meal, stop. Re-inject the fluid, close the port, skip the feeding, and check again in 1 hour (the stomach is not emptying properly).",
                        "Test the drawn fluid with a pH strip if instructed by your nurse; a pH less than 5.0 confirms the tube is securely in the stomach."
                    ],
                    isDefault: true,
                    imageSystemName: "ngt1",
                    category: ngt
                ),
                RoutineTask(
                    taskName: "Gravity-Fed Bolus NGT Feeding",
                    taskDescription: "Administering liquid nutritional formulas safely using natural gravity flow instead of forcing it.",
                    taskIcon: "fork.knife.circle.fill",
                    howTo: [
                        "Ensure the patient remains sitting upright at a 45-degree angle.",
                        "Clamp or pinch the NG tube with your fingers, remove the syringe plunger, and insert the empty syringe barrel into the tube opening.",
                        "Fill the syringe barrel with the prescribed amount of room-temperature formula.",
                        "Unclamp the tube and let the formula flow down naturally via gravity. Raise or lower the syringe to adjust the speed; a full feed should take 15 to 20 minutes.",
                        "Critical Airway Rule: Right before the syringe goes completely empty, clamp the tube again to prevent air from entering the stomach, which causes severe bloating and vomiting."
                    ],
                    isDefault: true,
                    imageSystemName: "ngt2",
                    category: ngt
                ),
                RoutineTask(
                    taskName: "Post-Feed Flush & Lock",
                    taskDescription: "Clearing the inner pipeline of the tube with fresh water to prevent thick formula from clotting and blocking the line.",
                    taskIcon: "lock.fill",
                    howTo: [
                        "Immediately following the formula feed, keep the tube clamped and pour 30 mL to 50 mL of clean, lukewarm water into the syringe barrel.",
                        "Unclamp the line and let the water flush through completely to rinse away sticky milk residues.",
                        "Clamp the tube tightly, remove the syringe, and close the safety cap on the NGT port securely.",
                        "The 30-Minute Stay Rule: Force the patient to remain sitting upright at a 45-degree angle for at least 30 to 60 minutes after the feed ends to prevent reflux and silent aspiration."
                    ],
                    isDefault: true,
                    imageSystemName: "ngt3",
                    category: ngt
                ),
            
			// MARK: - Category 7: Advanced Tracheostomy Support & Airway Clearing
            RoutineTask(
                    taskName: "Tracheostomy Suctioning Protocol",
                    taskDescription: "Using a mechanical suction machine to clear thick mucus blockages when the patient cannot cough them out effectively.",
                    taskIcon: "wind",
                    howTo: [
                        "Wash your hands thoroughly and don sterile medical gloves. Turn on the suction machine and verify the pressure gauge is set safely between 80 and 120 mmHg.",
                        "Open the sterile suction catheter package. Connect the catheter line to the suction machine tubing without letting the tip touch any unsterile surfaces.",
                        "Gently insert the catheter into the tracheostomy tube opening without applying suction (keep your thumb off the control valve) until you feel mild resistance or the patient coughs.",
                        "Place your thumb over the control valve to activate suction, and slowly pull the catheter out using a continuous, rotating motion.",
                        "The 10-Second Speed Limit: Never keep the suction active inside the airway for longer than 10 to 15 seconds, as you are pulling out their breathing oxygen. Flush the catheter with sterile saline water before repeating if needed."
                    ],
                    isDefault: true,
                    imageSystemName: "trach1",
                    category: trach
                ),
                RoutineTask(
                    taskName: "Inner Cannula Cleaning & Inspections",
                    taskDescription: "Removing and sanitizing the inner lining tube of the tracheostomy to prevent crusty mucus buildup from sealing the airway shut.",
                    taskIcon: "sparkles",
                    howTo: [
                        "Wash hands and steady the outer neck plate of the tracheostomy tube with your non-dominant hand.",
                        "Unlock the inner cannula by gently twisting or pinching the locking clips on the front connector.",
                        "Pull the inner cannula out toward you smoothly, following the natural downward curve of the neck line.",
                        "Drop the cannula into a sterile basin filled with half hydrogen peroxide and half sterile water. Use a small nylon trach brush to scrub away any dried, sticky mucus plugs.",
                        "Rinse the tube thoroughly in a separate basin of pure sterile saline, shake off excess moisture, and slide it gently back into the outer neck plate until you hear it distinctly snap lock into place."
                    ],
                    isDefault: true,
                    imageSystemName: "trach2",
                    category: trach
                ),
                RoutineTask(
                    taskName: "Emergency Trach Tube Dislodgement Response",
                    taskDescription: "Immediate emergency actions to take if the entire tracheostomy tube accidentally slips out of the neck stoma (hole).",
                    taskIcon: "exclamationmark.shield.fill",
                    howTo: [
                        "Do not panic. Call emergency services immediately or yell for help while staying directly beside the patient.",
                        "Tilt the patient’s head back slightly to extend the neck line and fully expose the open stoma hole.",
                        "Locate the emergency replacement tracheostomy tube (which must always be taped to the wall above the patient's bed).",
                        "Insert the guide tool (obturator) into the new inner tube, apply a tiny drop of water-soluble lubricant to the tip, and guide it gently back into the neck hole at a straight 90-degree angle.",
                        "Remove the internal guide tool immediately after insertion so the patient can draw air through the tube, and secure the neck ties tightly."
                    ],
                    isDefault: false, //FIXME: CHange
                    imageSystemName: "trach3",
                    category: trach
                )
        ]
	}
}
