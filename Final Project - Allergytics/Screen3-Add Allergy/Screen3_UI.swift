//
//  Screen3_UI.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/10/27.
//

import UIKit

class Screen3_UI: UIView {

    // MARK: - UI Components
    var scrollView: UIScrollView!           // Scroll View
    var contentView: UIView!                // Content View
    
    var labelTitle: UILabel!                // Label - Title
    
    var labelDateTime: UILabel!             // Label - Date Time
    var dateTimePicker: UIDatePicker!       // Date Time Picker
    
    var labelTrigger: UILabel!              // Label - Trigger
    var triggerContainer: UIStackView!      // Stack View - Trigger Container
    //var selectedTriggers: Set<String> = []
    let triggerOptions = ["Pollen",         // List - Trigger Options
                          "Sea Food",
                          "Dust",
                          "Medication",
                          "Environment",
                          "Weather",
                          "Other",
                          "Unknown"]
    var triggerButtons: [UIButton] = []
    var onTriggerSelectorTapped: ((UIButton) -> Void)?
    
    var labelSymptoms: UILabel!             // Label - Symptoms
    var symptomsContainer: UIStackView!     // Stack View - Symptoms Container
    //var selectedSymptoms = Set<String>()
    let symptomOptions: [String] = ["Itching",  // List - Symptom Options
                                    "Swelling",
                                    "Runny Nose",
                                    "Sneezing",
                                    "Cough",
                                    "Rash",
                                    "Other"]
    var symptomButtons: [UIButton] = []
    var onSymptomSelectorTapped: ((UIButton) -> Void)?
    
    var labelSeverity: UILabel!             // Label - Severity
    var severityPicker = UISegmentedControl()
    let severityOptions: [String] = ["Low",
                                     "Medium",
                                     "High"]
    
    var labelLocation: UILabel!             // Label - Location
    var locationSearchView: LocationSearch_UI!
    var textfieldLocation: UITextField!     // TextField - Location
    
    var labelAdditionalNotes: UILabel!
    var textViewAdditionalNotes: UITextView!
    var buttonSave: UIButton!
    var buttonDelete: UIButton!

    // MARK: - Initializer & View Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupScrollView()                       // Scroll View
        setupContentView()
        setupLabelTitle()                       // Label - Title
        setupLabelDateTime()                    // Label - Date Time
        setupDateTimePicker()                   // Date Time Picker
        setupLabelTrigger()                     // Label - Trigger
        setuptriggerContainer()                 // Trigger Container
        setupLabelSymptoms()                    // Label - Symptoms
        setupSymptomContainer()                 // Symptom Container
        setupLabelSeverity()                    // Label - Severity
        setupSeverityPicker()                   // Segmented Controll - Severity Picker
        setupLabelLocation()                    // Label - Location
        //setupLocationSearchView()               // Location Search
        setupTextFieldLocation()                // Text Field - Location
        setupLabelAdditionalNotes()             // Label - Additional Notes
        setupTextViewAdditionalNotes()          // Text View - Additional Notes
        setupButtonSave()                       // Button Save
        setupButtonDelete()
        
        initConstraints()                       // Constraints
    }
        
        
    // MARK: - UI Methods
        // Scroll View
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
        // Content View
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
        // Label - Title
    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.text = "Add Allergy"
        labelTitle.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        labelTitle.textColor = Colors().olive   // Olive Green
        labelTitle.textAlignment = .center
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelTitle)
    }
    
        // Label - Date Time
    func setupLabelDateTime() {
        labelDateTime = UILabel()
        labelDateTime.text = "Date / Time"
        labelDateTime.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelDateTime.textColor = Colors().brown
        labelDateTime.textAlignment = .center
        labelDateTime.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelDateTime)
    }
    
        // Date Time Picker
    func setupDateTimePicker() {
        dateTimePicker = UIDatePicker()
        dateTimePicker.datePickerMode = .dateAndTime
        dateTimePicker.minuteInterval = 5
        dateTimePicker.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(dateTimePicker)
    }
    
 
    
        // Label - Trigger
    func setupLabelTrigger() {
        labelTrigger = UILabel()
        labelTrigger.text = "Trigger"
        labelTrigger.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelTrigger.textColor = Colors().brown // Brown
        labelTrigger.textAlignment = .center
        labelTrigger.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelTrigger)
    }
    
        // Trigger Container
    func setuptriggerContainer() {
        triggerContainer = UIStackView()
        triggerContainer.axis = .vertical
        triggerContainer.spacing = 8
        triggerContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(triggerContainer)
        
        triggerButtons.removeAll()
        
        // Arrange trigger buttons in a 3x2 grid layout
        for i in stride(from: 0, to: triggerOptions.count, by: 2) {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 20
        
            // Add two buttons in each row
            for j in i..<min(i+2, triggerOptions.count) {
                let buttonTrigger = UIButton(type: .custom)
                buttonTrigger.setTitle(triggerOptions[j], for: .normal)
                buttonTrigger.setTitleColor(.darkGray, for: .normal)
                buttonTrigger.setImage(UIImage(systemName: "square"), for: .normal)
                buttonTrigger.tintColor = .darkGray
                buttonTrigger.contentHorizontalAlignment = .leading
                buttonTrigger.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
                
                
                // Add Action
                buttonTrigger.addAction(UIAction { _ in
                    self.onTriggerSelectorTapped?(buttonTrigger)
                }, for: .touchUpInside)
                
                // Add each triggers to the array for later access
                triggerButtons.append(buttonTrigger)
                
                rowStackView.addArrangedSubview(buttonTrigger)
                
            }
            // Add each horizontal row to the main vertical container
            triggerContainer.addArrangedSubview(rowStackView)
            
        }
    }
    
        
        // Label - Symtoms
    func setupLabelSymptoms() {
        labelSymptoms = UILabel()
        labelSymptoms.text = "Symptoms"
        labelSymptoms.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelSymptoms.textColor = Colors().brown    // Brown
        labelSymptoms.textAlignment = .center
        labelSymptoms.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelSymptoms)
    }
    
        // Symptom Container
    func setupSymptomContainer() {
        symptomsContainer = UIStackView()
        symptomsContainer.axis = .vertical
        symptomsContainer.spacing = 8
        symptomsContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(symptomsContainer)
        
        symptomButtons.removeAll()
        
        // Arrange trigger buttons in a 3x2 grid layout
        for i in stride(from: 0, to: symptomOptions.count, by: 2) {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 20
            
            // Add two buttons in each row
                // Loop through two items at a time, but stop if reaching the end of the list
            for j in i..<min(i+2, symptomOptions.count) {
                let buttonSymptom = UIButton(type: .custom)
                buttonSymptom.setTitle(symptomOptions[j], for: .normal)
                buttonSymptom.setTitleColor(.darkGray, for: .normal)
                buttonSymptom.contentHorizontalAlignment = .leading
                buttonSymptom.setImage(UIImage(systemName: "square"), for: .normal)
                buttonSymptom.tintColor = .darkGray
                // Add space between checkbox and text
                buttonSymptom.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
                
                // Add Button Action
                buttonSymptom.addAction(UIAction { _ in
                    self.onSymptomSelectorTapped?(buttonSymptom)
                }, for: .touchUpInside)
                
                // Add each symptoms to the array for later access
                symptomButtons.append(buttonSymptom)
                
                rowStackView.addArrangedSubview(buttonSymptom)
                
            }
            // Add each horizontal row to the main vertical container
            symptomsContainer.addArrangedSubview(rowStackView)
            
        }
    }
    
        // Label - Severity
    func setupLabelSeverity() {
        labelSeverity = UILabel()
        labelSeverity.text = "Severity"
        labelSeverity.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelSeverity.textColor = Colors().brown    // Brown
        labelSeverity.textAlignment = .center
        labelSeverity.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelSeverity)
    }
    
        // Severity Picker
    func setupSeverityPicker() {
        severityPicker = UISegmentedControl(items: severityOptions)
        
        // default selection
        severityPicker.selectedSegmentIndex = 0
        
        // customize appearance
        severityPicker.selectedSegmentTintColor = Colors().olive
        severityPicker.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        severityPicker.setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)
        severityPicker.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(severityPicker)
    }
    
    
        // Label - Location
    func setupLabelLocation() {
        labelLocation = UILabel()
        labelLocation.text = "Location"
        labelLocation.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelLocation.textColor = Colors().brown    // Brown
        labelLocation.textAlignment = .center
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelLocation)
    }
    
    
        // TextField - Location
    func setupTextFieldLocation() {
        textfieldLocation = UITextField()
        textfieldLocation.placeholder = "Enter Location"
        textfieldLocation.borderStyle = .roundedRect
        textfieldLocation.font = UIFont.systemFont(ofSize: 17)
        // Disable autocorrect and suggestions to prevent iOS autocorrect bubble crashes.
        textfieldLocation.autocorrectionType = .no
        textfieldLocation.spellCheckingType = .no
        textfieldLocation.autocapitalizationType = .none
        textfieldLocation.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textfieldLocation)
    }
    
    
        // Label - Additional Notes
    func setupLabelAdditionalNotes() {
        labelAdditionalNotes = UILabel()
        labelAdditionalNotes.text = "Additional Notes"
        labelAdditionalNotes.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelAdditionalNotes.textColor = Colors().brown // Brown
        labelAdditionalNotes.textAlignment = .center
        labelAdditionalNotes.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelAdditionalNotes)
    }
    
        // Text Field - Additional Notes
    func setupTextViewAdditionalNotes() {
        textViewAdditionalNotes = UITextView()
        textViewAdditionalNotes.font = UIFont.systemFont(ofSize: 16)
        textViewAdditionalNotes.textColor = .darkGray
        textViewAdditionalNotes.backgroundColor = .white
        textViewAdditionalNotes.layer.borderWidth = 1
        textViewAdditionalNotes.layer.borderColor = UIColor.systemGray4.cgColor
        textViewAdditionalNotes.layer.cornerRadius = 8
        textViewAdditionalNotes.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textViewAdditionalNotes)
    }
        // Button - Save
    func setupButtonSave() {
        buttonSave = UIButton(type: .system)
        buttonSave.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.setTitleColor(.white, for: .normal)
        buttonSave.backgroundColor = Colors().olive // Olive Green
        buttonSave.layer.cornerRadius = 8
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonSave)
    }
    
    // Button - Delete
    func setupButtonDelete() {
        buttonDelete = UIButton(type: .system)
        buttonDelete.setTitle("Delete Allergy", for: .normal)
        buttonDelete.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        buttonDelete.setTitleColor(.red, for: .normal)
        buttonDelete.backgroundColor = Colors().offwhite
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.isHidden = true
        scrollView.addSubview(buttonDelete)
    }
    
        // Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
                // Scroll View
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor),
            
                // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            
                // Label - Title
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
                // Label - Date Time
            labelDateTime.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 35),
            labelDateTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            
                // Date Time Picker
            dateTimePicker.centerYAnchor.constraint(equalTo: labelDateTime.centerYAnchor),
            dateTimePicker.leadingAnchor.constraint(equalTo: labelDateTime.trailingAnchor, constant: 10),
            dateTimePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
                // Label - Trigger
            labelTrigger.topAnchor.constraint(equalTo: dateTimePicker.bottomAnchor, constant: 30),
            labelTrigger.leadingAnchor.constraint(equalTo:labelDateTime.leadingAnchor),
            
                // Trigger Container
            triggerContainer.topAnchor.constraint(equalTo: labelTrigger.bottomAnchor, constant: 15),
            triggerContainer.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 50),
            triggerContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -50),
            
                // Label - Symptoms
            labelSymptoms.topAnchor.constraint(equalTo: triggerContainer.bottomAnchor, constant: 30),
            labelSymptoms.leadingAnchor.constraint(equalTo:labelDateTime.leadingAnchor),
            
                // Symptom Container
            symptomsContainer.topAnchor.constraint(equalTo: labelSymptoms.bottomAnchor, constant: 15),
            symptomsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            symptomsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
                // Label - Severity
            labelSeverity.topAnchor.constraint(equalTo: symptomsContainer.bottomAnchor, constant: 30),
            labelSeverity.leadingAnchor.constraint(equalTo:labelDateTime.leadingAnchor),
            
                // Segmented Controll - Severity Picker
            severityPicker.centerYAnchor.constraint(equalTo: labelSeverity.centerYAnchor),
            severityPicker.leadingAnchor.constraint(equalTo: labelSeverity.trailingAnchor, constant: 15),
            severityPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
                // Label - Location
            labelLocation.topAnchor.constraint(equalTo: severityPicker.bottomAnchor, constant: 30),
            labelLocation.leadingAnchor.constraint(equalTo:labelDateTime.leadingAnchor),
            
                // Text Field - Location
            textfieldLocation.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 10),
            textfieldLocation.leadingAnchor.constraint(equalTo: labelLocation.leadingAnchor),
            textfieldLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            textfieldLocation.heightAnchor.constraint(equalToConstant: 40),
            
                // Label - Additional Notes
            labelAdditionalNotes.topAnchor.constraint(equalTo: textfieldLocation.bottomAnchor, constant: 30),
            labelAdditionalNotes.leadingAnchor.constraint(equalTo:labelDateTime.leadingAnchor),
            
                // Text View - Additional Notes
            textViewAdditionalNotes.topAnchor.constraint(equalTo: labelAdditionalNotes.bottomAnchor, constant: 10),
            textViewAdditionalNotes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            textViewAdditionalNotes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            textViewAdditionalNotes.heightAnchor.constraint(equalToConstant: 80),
            
                // Button - Save
            buttonSave.topAnchor.constraint(equalTo: textViewAdditionalNotes.bottomAnchor, constant: 25),
            buttonSave.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonSave.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25),
            buttonSave.widthAnchor.constraint(equalToConstant: 150),
            
                // Button - Delete
            buttonDelete.topAnchor.constraint(equalTo: buttonSave.topAnchor),
            buttonDelete.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonDelete.bottomAnchor.constraint(equalTo: buttonSave.bottomAnchor),
            buttonDelete.widthAnchor.constraint(equalTo: buttonSave.widthAnchor),
             
        ])
    }
    
        
    // MARK: - Required for Storyboard/XIB, not used here (programmatic only)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
