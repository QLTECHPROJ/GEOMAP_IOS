//
//  KidsAttendenceCell.swift
//  NSC_iOS
//
//  Created by Mac Mini on 27/04/22.
//

import UIKit

class KidsAttendenceCell: UITableViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewStatus: UIView!
    
    @IBOutlet weak var lblKidName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblGroupName: UILabel!
    
    @IBOutlet weak var viewMorning: UIView!
    @IBOutlet weak var viewLunch: UIView!
    @IBOutlet weak var viewCheckout: UIView!
    
    @IBOutlet weak var lblMorningStatus: UILabel!
    @IBOutlet weak var lblLunchStatus: UILabel!
    @IBOutlet weak var lblCheckOutStatus: UILabel!
    
    @IBOutlet weak var viewMorningAttendance: UIView!
    @IBOutlet weak var viewLunchAttendance: UIView!
    
    @IBOutlet weak var btnPresentM: UIButton!
    @IBOutlet weak var btnAbsentM: UIButton!
    
    @IBOutlet weak var btnPresentPL: UIButton!
    @IBOutlet weak var btnAbsentPL: UIButton!
    
    @IBOutlet weak var btnCheckOut: UIButton!
    
    
    // MARK: - VARIABLES
    var didChangeAttendance: (() -> Void)?
    var didClickCheckOut: (() -> Void)?
    
    var kidsData: KidsAttendanceDetailModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBack.dropShadow()
    }
    
    override func prepareForReuse() {
        btnPresentM.setImage(UIImage(named: "CheckDeselect"), for: .normal)
        btnAbsentM.setImage(UIImage(named: "CheckDeselect"), for: .normal)
        
        btnPresentPL.setImage(UIImage(named: "CheckDeselect"), for: .normal)
        btnAbsentPL.setImage(UIImage(named: "CheckDeselect"), for: .normal)
    }

    // Configure Cell
    func configureCell(data : KidsAttendanceDetailModel, dayshift : String) {
        self.kidsData = data
        
        lblKidName.text = data.Name
        lblGroupName.text = data.Group_Name
        
        lblStatus.text = data.isFirstTimer == "0" ? "First timer" : ""
        
        DispatchQueue.main.async {
            if data.CheckIn == CheckInStatus.checkIn.rawValue {
                self.viewStatus.backgroundColor = Theme.colors.green_008D36
            } else if data.CheckIn == CheckInStatus.checkOut.rawValue {
                self.viewStatus.backgroundColor = Theme.colors.theme_dark
            } else {
                self.viewStatus.backgroundColor = Theme.colors.yellow_F3DE29
            }
        }
        
        let shiftStatus = DayShiftStatus(rawValue: dayshift) ?? .none
        switch shiftStatus {
        case .morning:
            viewMorning.isHidden = false
            viewLunch.isHidden = true
            viewCheckout.isHidden = true
        case .lunch:
            viewMorning.isHidden = false
            viewLunch.isHidden = false
            viewCheckout.isHidden = true
        case .checkout:
            viewMorning.isHidden = false
            viewLunch.isHidden = false
            viewCheckout.isHidden = false
        default:
            viewMorning.isHidden = false
            viewLunch.isHidden = false
            viewCheckout.isHidden = false
        }
        
        setupMorningUI(data: data, shiftStatus: shiftStatus)
        setupLunchUI(data: data, shiftStatus: shiftStatus)
        setupCheckOutUI(data: data, shiftStatus: shiftStatus)
    }
    
    func setupMorningUI(data : KidsAttendanceDetailModel, shiftStatus : DayShiftStatus) {
        if data.CheckIn == CheckInStatus.checkIn.rawValue && shiftStatus == .morning {
            viewMorningAttendance.isHidden = false
            lblMorningStatus.isHidden = true
        } else {
            viewMorningAttendance.isHidden = true
            lblMorningStatus.isHidden = false
        }
        
        if data.Morning_Attendance == AttendanceStatus.present.rawValue {
            btnPresentM.setImage(UIImage(named: "CheckSelect"), for: .normal)
            btnAbsentM.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            lblMorningStatus.text = "Present"
        } else if data.Morning_Attendance == AttendanceStatus.absent.rawValue {
            btnPresentM.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            btnAbsentM.setImage(UIImage(named: "CheckSelect"), for: .normal)
            lblMorningStatus.text = "Absent"
        } else {
            btnPresentM.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            btnAbsentM.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            lblMorningStatus.text = "-"
        }
    }
    
    func setupLunchUI(data : KidsAttendanceDetailModel, shiftStatus : DayShiftStatus) {
        if data.CheckIn == CheckInStatus.checkIn.rawValue && shiftStatus == .lunch {
            viewLunchAttendance.isHidden = false
            lblLunchStatus.isHidden = true
        } else {
            viewLunchAttendance.isHidden = true
            lblLunchStatus.isHidden = false
        }
        
        if data.Lunch_Attendance == AttendanceStatus.present.rawValue {
            btnPresentPL.setImage(UIImage(named: "CheckSelect"), for: .normal)
            btnAbsentPL.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            lblLunchStatus.text = "Present"
        } else if data.Lunch_Attendance == AttendanceStatus.absent.rawValue {
            btnPresentPL.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            btnAbsentPL.setImage(UIImage(named: "CheckSelect"), for: .normal)
            lblLunchStatus.text = "Absent"
        } else {
            btnPresentPL.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            btnAbsentPL.setImage(UIImage(named: "CheckDeselect"), for: .normal)
            lblLunchStatus.text = "-"
        }
    }
    
    func setupCheckOutUI(data : KidsAttendanceDetailModel, shiftStatus : DayShiftStatus) {
        if data.CheckIn == CheckInStatus.checkIn.rawValue && shiftStatus == .checkout {
            btnCheckOut.isHidden = false
            btnCheckOut.isUserInteractionEnabled = true
            lblCheckOutStatus.isHidden = true
        } else if data.CheckIn == CheckInStatus.checkOut.rawValue && shiftStatus == .checkout {
            btnCheckOut.isHidden = false
            btnCheckOut.isUserInteractionEnabled = true
            lblCheckOutStatus.isHidden = true
        } else if data.CheckIn == CheckInStatus.checkOut.rawValue {
            btnCheckOut.isHidden = false
            btnCheckOut.isUserInteractionEnabled = false
            lblCheckOutStatus.isHidden = true
        } else {
            btnCheckOut.isHidden = true
            lblCheckOutStatus.isHidden = false
            lblCheckOutStatus.text = "-"
        }
        
        if data.CheckIn == CheckInStatus.checkOut.rawValue {
            btnCheckOut.setImage(UIImage(named: "CheckSelect"), for: .normal)
        } else {
            btnCheckOut.setImage(UIImage(named: "CheckDeselect"), for: .normal)
        }
    }
    
    
    // MARK: - ACTIONS
    @IBAction func morningAttendanceChanged(_ sender: UIButton) {
        if let kidsData = kidsData {
            kidsData.Morning_Attendance = "\(sender.tag)"
        }
        
        self.didChangeAttendance?()
    }
    
    @IBAction func postLunchAttendanceChanged(_ sender: UIButton) {
        if let kidsData = kidsData {
            kidsData.Lunch_Attendance = "\(sender.tag)"
        }
        
        self.didChangeAttendance?()
    }
    
    @IBAction func checkoutClicked(_ sender: UIButton) {
        if let kidsData = kidsData {
            if kidsData.CheckIn == CheckInStatus.checkIn.rawValue {
                kidsData.CheckIn = CheckInStatus.checkOut.rawValue
            } else {
                kidsData.CheckIn = CheckInStatus.checkIn.rawValue
            }
        }
        
        self.didClickCheckOut?()
    }
    
}
