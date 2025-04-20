//
//  UUID+Extension.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 19/10/24.
//

import CloudKit

extension UUID {
    public init?(_ ckRecordID: CKRecord.ID) {
        self.init(uuidString: ckRecordID.recordName)
    }
    
    public var ckRecordID: CKRecord.ID {
        CKRecord.ID(recordName: uuidString)
    }
}
