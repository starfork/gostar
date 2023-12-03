package mysql

import ( 

	"gorm.io/gorm"

	db "github.com/starfork/stargo/store/mysql"  
	pb "{{.ServiceName}}/pkg/pb"
 
	mp "github.com/mitchellh/mapstructure"
	 
)

type {{ucwords .Name}} struct {
	DeletedAt gorm.DeletedAt `gorm:"index"`
	*pb.{{ucwords .Name}} 
}

func (p *{{ucwords .Name}}) Unmarshal() { 
}
  
func (e *Repo) Create{{ucwords .Name}}(req *pb.{{ucwords .Name}}CreateRequest) (*pb.{{ucwords .Name}}, error) {
	data :=  &pb.{{ucwords .Name}}{} 
	mp.Decode(req, &data)
	if  err := e.db.Create(&data).Error; err != nil {
		return nil,err
	} 

	return data, nil
}
 
func (e *Repo) Update{{ucwords .Name}}(req *pb.{{ucwords .Name}}UpdateRequest) (*pb.{{ucwords .Name}}, error) {
	data := &pb.{{ucwords .Name}}{}
	mp.Decode(req, &data)
	if err := e.db.Updates(&data).Error; err != nil {
		return nil,err
	} 
	return data, nil
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

 