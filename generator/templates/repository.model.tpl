package mysql

import ( 
	"gorm.io/gorm"
	"time"

	db "github.com/starfork/stargo/store/mysql"  
	pb "service/{{.ServiceName}}/pkg/pb"
 
	mp "github.com/mitchellh/mapstructure"
	 
)

type {{ucwords .Name}} struct {
	*pb.{{ucwords .Name}} 
	Dtm gorm.DeletedAt `gorm:"index:dtm"`
	Ctm time.Time      `gorm:"default:CURRENT_TIMESTAMP(3);"`
	Utm time.Time      `gorm:"default:NULL ON UPDATE CURRENT_TIMESTAMP(3);"`
}

func (p *{{ucwords .Name}}) Unmarshal() { 
	
}
  
func (e *Repo) Create{{ucwords .Name}}(req *pb.{{ucwords .Name}}CreateRequest) (*pb.{{ucwords .Name}}, error) {
	data :=  &{{ucwords .Name}}{} 
	mp.Decode(req, &data.{{ucwords .Name}})
	if  err := e.db.Create(&data).Error; err != nil {
		return nil,err
	} 
	//data.Unmarshal()
	return data.{{ucwords .Name}}, nil 
}
 
func (e *Repo) Update{{ucwords .Name}}(req *pb.{{ucwords .Name}}UpdateRequest) (*pb.{{ucwords .Name}}, error) {
	rs := &pb.{{ucwords .Name}}{Id: req.GetId()}
	if err := e.db.First(rs).Error; err != nil {
		return nil, err
	}
	data := &{{ucwords .Name}}{}
	mp.Decode(req, &data.{{ucwords .Name}})
	if err := e.db.Unscoped().Updates(&data).Error; err != nil {
		return nil, err
	}
	return data.{{ucwords .Name}}, nil
}

func (e *Repo) Read{{ucwords .Name}}(req *pb.{{ucwords .Name}}FetchRequest) (*pb.{{ucwords .Name}}, error) {
	maps := &pb.{{ucwords .Name}}{}
	mp.Decode(req,&maps)
	data := {{ucwords .Name}}{
		{{ucwords .Name}}: &pb.{{ucwords .Name}}{},
	}
	if err := e.db.Where(maps).First(&data).Error; err != nil {
		return nil, err
	} 

	return data.{{ucwords .Name}}, nil 
}

func (e *Repo) Delete{{ucwords .Name}}(req *pb.{{ucwords .Name}}DeleteRequest) (*pb.Response, error) {
	maps :=  &pb.{{ucwords .Name}}{} 
	mp.Decode(req, &maps)
	if  err := e.db.Where(&maps).Delete(&{{ucwords .Name}}{}).Error; err != nil {
		return nil,err
	} 
	return &pb.Response{Msg: "success"}, nil
}

func (e *Repo) Fetch{{ucwords .Name}}(req *pb.{{ucwords .Name}}FetchRequest) (*pb.{{ucwords .Name}}Response, error) {
	rs := []*{{ucwords .Name}}{}
	maps := pb.{{ucwords .Name}}{}
	mp.Decode(req, &maps)

	var total int64
	d:=e.db.Model(&pb.{{ucwords .Name}}{})
	//todo 补充其他map
	d.Where(&maps).Count(&total)	 
	if total == 0 {
		return &pb.{{ucwords .Name}}Response{}, nil
	} 

	if err := d.Scopes(db.Page(req.GetP(), req.GetL())). 
		//Order("id desc").//这了自行修改
		Find(&rs).Error; err != nil {
		return nil,err
	}

	data := []*pb.{{ucwords .Name}}{}
	for _, v := range rs {
		data = append(data, v.{{ucwords .Name}})
	} 
	return &pb.{{ucwords .Name}}Response{Count: total, Data: data}, nil
}

 